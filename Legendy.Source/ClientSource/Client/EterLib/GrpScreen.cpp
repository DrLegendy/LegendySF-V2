#include "StdAfx.h"
#include "GrpScreen.h"
#include "Camera.h"
#include "StateManager.h"

DWORD		CScreen::ms_diffuseColor = 0xffffffff;
DWORD		CScreen::ms_clearColor = 0L;
DWORD		CScreen::ms_clearStencil = 0L;
float		CScreen::ms_clearDepth = 1.0f;
Frustum		CScreen::ms_frustum;

extern bool GRAPHICS_CAPS_CAN_NOT_DRAW_LINE;

void CScreen::RenderLine3d(float sx, float sy, float sz, float ex, float ey, float ez)
{
	if (GRAPHICS_CAPS_CAN_NOT_DRAW_LINE)
		return;

	assert(ms_lpd3dDevice != NULL);

	SPDTVertexRaw vertices[2] =
	{
		{ sx, sy, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, ey, ez, ms_diffuseColor, 0.0f, 0.0f }
	};

	// 2004.11.18.myevan.DrawIndexPrimitiveUP -> DynamicVertexBuffer
	if (SetPDTStream(vertices, 2))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.DrawPrimitive(D3DPT_LINELIST, 0, 1);
	}
}

void CScreen::RenderBox3d(float sx, float sy, float sz, float ex, float ey, float ez)
{
	if (GRAPHICS_CAPS_CAN_NOT_DRAW_LINE)
		return;

	assert(ms_lpd3dDevice != NULL);

	SPDTVertexRaw vertices[8] =
	{
		{ sx, sy, sz, ms_diffuseColor, 0.0f, 0.0f },	// 0
		{ ex, sy, sz, ms_diffuseColor, 0.0f, 0.0f },	// 1

		{ sx, sy, sz, ms_diffuseColor, 0.0f, 0.0f },	// 0
		{ sx, ey, ez, ms_diffuseColor, 0.0f, 0.0f },	// 2

		{ ex, sy, sz, ms_diffuseColor, 0.0f, 0.0f },	// 1
		{ ex, ey, ez, ms_diffuseColor, 0.0f, 0.0f },	// 3

		{ sx, ey, ez, ms_diffuseColor, 0.0f, 0.0f },	// 2
		{ ex+1.0f, ey, ez, ms_diffuseColor, 0.0f, 0.0f }
	};

	// 2004.11.18.myevan.DrawIndexPrimitiveUP -> DynamicVertexBuffer
	if (SetPDTStream(vertices, 8))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.DrawPrimitive(D3DPT_LINELIST, 0, 4);
	}
}

void CScreen::RenderBar3d(float sx, float sy, float sz, float ex, float ey, float ez)
{
	assert(ms_lpd3dDevice != NULL);

	SPDTVertexRaw vertices[4] =
	{
		{ sx, sy, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ sx, ey, ez, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, sy, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, ey, ez, ms_diffuseColor, 0.0f, 0.0f },
	};



	if (SetPDTStream(vertices, 4))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
	}
}

void CScreen::RenderBar3d(const D3DXVECTOR3 * c_pv3Positions)
{
	assert(ms_lpd3dDevice != NULL);

	SPDTVertexRaw vertices[4] =
	{
		{ c_pv3Positions[0].x, c_pv3Positions[0].y, c_pv3Positions[0].z, ms_diffuseColor, 0.0f, 0.0f },
		{ c_pv3Positions[2].x, c_pv3Positions[2].y, c_pv3Positions[2].z, ms_diffuseColor, 0.0f, 0.0f },
		{ c_pv3Positions[1].x, c_pv3Positions[1].y, c_pv3Positions[1].z, ms_diffuseColor, 0.0f, 0.0f },
		{ c_pv3Positions[3].x, c_pv3Positions[3].y, c_pv3Positions[3].z, ms_diffuseColor, 0.0f, 0.0f },
	};


	if (SetPDTStream(vertices, 4))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
	}
}

void CScreen::RenderGradationBar3d(float sx, float sy, float sz, float ex, float ey, float ez, DWORD dwStartColor, DWORD dwEndColor)
{
	assert(ms_lpd3dDevice != NULL);
	if (sx==ex) return;
	if (sy==ey) return;

	SPDTVertexRaw vertices[4] =
	{
		{ sx, sy, sz, dwStartColor, 0.0f, 0.0f },
		{ sx, ey, ez, dwEndColor, 0.0f, 0.0f },
		{ ex, sy, sz, dwStartColor, 0.0f, 0.0f },
		{ ex, ey, ez, dwEndColor, 0.0f, 0.0f },
	};

	if (SetPDTStream(vertices, 4))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
	}
}

void CScreen::RenderLineCube(float sx, float sy, float sz, float ex, float ey, float ez)
{
	SPDTVertexRaw vertices[8] =
	{
		{ sx, sy, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, sy, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ sx, ey, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, ey, sz, ms_diffuseColor, 0.0f, 0.0f },
		{ sx, sy, ez, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, sy, ez, ms_diffuseColor, 0.0f, 0.0f },
		{ sx, ey, ez, ms_diffuseColor, 0.0f, 0.0f },
		{ ex, ey, ez, ms_diffuseColor, 0.0f, 0.0f },
	};


	if (SetPDTStream(vertices, 8))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.SetTransform(D3DTS_WORLD, ms_lpd3dMatStack->GetTop());
		SetDefaultIndexBuffer(DEFAULT_IB_LINE_CUBE);

		STATEMANAGER.DrawIndexedPrimitive(D3DPT_LINELIST, 0, 8, 0, 4*3);
	}
}

void CScreen::RenderCube(float sx, float sy, float sz, float ex, float ey, float ez)
{
	SPDTVertexRaw vertices[8] =
	{
		{ sx, sy, sz, ms_diffuseColor, 0.0f, 0.0f  },
		{ ex, sy, sz, ms_diffuseColor, 0.0f, 0.0f  },
		{ sx, ey, sz, ms_diffuseColor, 0.0f, 0.0f  },
		{ ex, ey, sz, ms_diffuseColor, 0.0f, 0.0f  },
		{ sx, sy, ez, ms_diffuseColor, 0.0f, 0.0f  },
		{ ex, sy, ez, ms_diffuseColor, 0.0f, 0.0f  },
		{ sx, ey, ez, ms_diffuseColor, 0.0f, 0.0f  },
		{ ex, ey, ez, ms_diffuseColor, 0.0f, 0.0f  },
	};


	if (SetPDTStream(vertices, 8))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.SetTransform(D3DTS_WORLD, ms_lpd3dMatStack->GetTop());

		SetDefaultIndexBuffer(DEFAULT_IB_FILL_CUBE);
		STATEMANAGER.DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, 8, 0, 4*3);
	}
}

void CScreen::RenderCube(float sx, float sy, float sz, float ex, float ey, float ez, D3DXMATRIX matRotation)
{
	D3DXVECTOR3 v3Center = D3DXVECTOR3((sx + ex) * 0.5f, (sy + ey) * 0.5f, (sz + ez) * 0.5f);
	D3DXVECTOR3 v3Vertex[8] =
	{
		D3DXVECTOR3(sx, sy, sz),
		D3DXVECTOR3(ex, sy, sz),
		D3DXVECTOR3(sx, ey, sz),
		D3DXVECTOR3(ex, ey, sz),
		D3DXVECTOR3(sx, sy, ez),
		D3DXVECTOR3(ex, sy, ez),
		D3DXVECTOR3(sx, ey, ez),
		D3DXVECTOR3(ex, ey, ez),
	};
	SPDTVertexRaw vertices[8];

	for(int i = 0; i < 8; i++)
	{
		v3Vertex[i] = v3Vertex[i] - v3Center;
		D3DXVec3TransformCoord(&v3Vertex[i], &v3Vertex[i], &matRotation);
		v3Vertex[i] = v3Vertex[i] + v3Center;
		vertices[i].px = v3Vertex[i].x;
		vertices[i].py = v3Vertex[i].y;
		vertices[i].pz = v3Vertex[i].z;
		vertices[i].diffuse = ms_diffuseColor;
		vertices[i].u = 0.0f; vertices[i].v = 0.0f;
	}

	if (SetPDTStream(vertices, 8))
	{
		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
		STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
		STATEMANAGER.SetTransform(D3DTS_WORLD, ms_lpd3dMatStack->GetTop());

		SetDefaultIndexBuffer(DEFAULT_IB_FILL_CUBE);
		STATEMANAGER.DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, 8, 0, 4*3);
	}
}

void CScreen::RenderLine2d(float sx, float sy, float ex, float ey, float z)
{
	RenderLine3d(sx, sy, z, ex, ey, z);
}

void CScreen::RenderBox2d(float sx, float sy, float ex, float ey, float z)
{
	RenderBox3d(sx, sy, z, ex, ey, z);
}

void CScreen::RenderBar2d(float sx, float sy, float ex, float ey, float z)
{
	RenderBar3d(sx, sy, z, ex, ey, z);
}

void CScreen::RenderGradationBar2d(float sx, float sy, float ex, float ey, DWORD dwStartColor, DWORD dwEndColor, float ez)
{
	RenderGradationBar3d(sx, sy, ez, ex, ey, ez, dwStartColor, dwEndColor);
}

void CScreen::RenderCircle2d(float fx, float fy, float fz, float fRadius, int iStep)
{
	int count;
	float theta, delta;
	float x, y, z;
	std::vector<D3DXVECTOR3> pts;

	pts.clear();
	pts.resize(iStep);

	theta = 0.0;
	delta = 2 * D3DX_PI / float(iStep);

	for (count=0; count<iStep; count++)
	{
		x = fx + fRadius * cosf(theta);
		y = fy + fRadius * sinf(theta);
		z = fz;

		pts[count] = D3DXVECTOR3(x, y, z);

		theta += delta;
	}
	for (count=0; count<iStep - 1; count++)
	{
		RenderLine3d(pts[count].x, pts[count].y, pts[count].z, pts[count + 1].x, pts[count + 1].y, pts[count + 1].z);
	}
	RenderLine3d(pts[iStep - 1].x, pts[iStep - 1].y, pts[iStep - 1].z, pts[0].x, pts[0].y, pts[0].z);
}

void CScreen::RenderCircle3d(float fx, float fy, float fz, float fRadius, int iStep)
{
	int count;
	float theta, delta;
	std::vector<D3DXVECTOR3> pts;

	pts.clear();
	pts.resize(iStep);

	theta = 0.0;
	delta = 2 * D3DX_PI / float(iStep);

	const D3DXMATRIX & c_rmatInvView = CCameraManager::Instance().GetCurrentCamera()->GetBillboardMatrix();

	for (count=0; count<iStep; count++)
	{
		pts[count] = D3DXVECTOR3(fRadius * cosf(theta), fRadius * sinf(theta), 0.0f);
		D3DXVec3TransformCoord(&pts[count], &pts[count], &c_rmatInvView);

		theta += delta;
	}
	for (count=0; count<iStep - 1; count++)
	{
		RenderLine3d(fx+pts[count].x, fy+pts[count].y, fz+pts[count].z,
					 fx+pts[count + 1].x, fy+pts[count + 1].y, fz+pts[count + 1].z);
	}
	RenderLine3d(fx+pts[iStep - 1].x, fy+pts[iStep - 1].y, fz+pts[iStep - 1].z,
				 fx+pts[0].x, fy+pts[0].y, fz+pts[0].z);
}

class CD3DXMeshRenderingOption : public CScreen
{
public:
	DWORD	m_dwVS;

	CD3DXMeshRenderingOption(D3DFILLMODE d3dFillMode, const D3DXMATRIX & c_rmatWorld)
	{
		ms_lpd3dDevice->GetVertexShader(&m_dwVS);

		STATEMANAGER.SaveTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TFACTOR);
		STATEMANAGER.SaveTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1);
		STATEMANAGER.SaveTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_DISABLE);
		STATEMANAGER.SetRenderState(D3DRS_FILLMODE, d3dFillMode);
		STATEMANAGER.SaveTransform(D3DTS_WORLD, &c_rmatWorld);

		STATEMANAGER.SetTexture(0, NULL);
		STATEMANAGER.SetTexture(1, NULL);
	}

	virtual ~CD3DXMeshRenderingOption()
	{
		ms_lpd3dDevice->SetVertexShader(m_dwVS);

		STATEMANAGER.RestoreTransform(D3DTS_WORLD);
		STATEMANAGER.RestoreTextureStageState(0, D3DTSS_COLORARG1);
		STATEMANAGER.RestoreTextureStageState(0, D3DTSS_COLOROP);
		STATEMANAGER.RestoreTextureStageState(0, D3DTSS_ALPHAOP);
		STATEMANAGER.SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
	}
};

void CScreen::RenderD3DXMesh(LPD3DXMESH lpMesh, const D3DXMATRIX * c_pmatWorld, float fx, float fy, float fz, float fRadius, D3DFILLMODE d3dFillMode)
{
	D3DXMATRIX matTranslation;
	D3DXMATRIX matScaling;

	D3DXMatrixTranslation(&matTranslation, fx, fy, fz);
	D3DXMatrixScaling(&matScaling, fRadius, fRadius, fRadius);

	D3DXMATRIX matWorld;
	matWorld = matScaling * matTranslation;

	if (c_pmatWorld)
	{
		matWorld *= *c_pmatWorld;
	}

	CD3DXMeshRenderingOption SetRenderingOption(d3dFillMode, matWorld);
	LPDIRECT3DINDEXBUFFER8 lpIndexBuffer;
	LPDIRECT3DVERTEXBUFFER8 lpVertexBuffer;
	lpMesh->GetIndexBuffer(&lpIndexBuffer);
	lpMesh->GetVertexBuffer(&lpVertexBuffer);
	STATEMANAGER.SetVertexShader(lpMesh->GetFVF());
	STATEMANAGER.SetIndices(lpIndexBuffer, 0);
	STATEMANAGER.SetStreamSource(0, lpVertexBuffer, 24);
	STATEMANAGER.DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, lpMesh->GetNumVertices(), 0, lpMesh->GetNumFaces());
}

void CScreen::RenderSphere(const D3DXMATRIX * c_pmatWorld, float fx, float fy, float fz, float fRadius, D3DFILLMODE d3dFillMode)
{
	RenderD3DXMesh(ms_lpSphereMesh, c_pmatWorld, fx, fy, fz, fRadius, d3dFillMode);
}

void CScreen::RenderCylinder(const D3DXMATRIX * c_pmatWorld, float fx, float fy, float fz, float fRadius, float /*fLength*/, D3DFILLMODE d3dFillMode)
{
	RenderD3DXMesh(ms_lpCylinderMesh, c_pmatWorld, fx, fy, fz, fRadius, d3dFillMode);
}

void CScreen::RenderTextureBox(float sx, float sy, float ex, float ey, float z, float su, float sv, float eu, float ev)
{
	assert(ms_lpd3dDevice != NULL);

	TPDTVertex vertices[4];

	vertices[0].position = TPosition(sx, sy, z);
	vertices[0].diffuse = ms_diffuseColor;
	vertices[0].texCoord = TTextureCoordinate(su, sv);

	vertices[1].position = TPosition(ex, sy, z);
	vertices[1].diffuse = ms_diffuseColor;
	vertices[1].texCoord = TTextureCoordinate(eu, sv);

	vertices[2].position = TPosition(sx, ey, z);
	vertices[2].diffuse = ms_diffuseColor;
	vertices[2].texCoord = TTextureCoordinate(su, ev);

	vertices[3].position = TPosition(ex, ey, z);
	vertices[3].diffuse = ms_diffuseColor;
	vertices[3].texCoord = TTextureCoordinate(eu, ev);

#ifdef WORLD_EDITOR
	STATEMANAGER.SetTransform(D3DTS_WORLD, ms_lpd3dMatStack->GetTop());
#endif
	STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);

	// 2004.11.18.myevan.DrawIndexPrimitiveUP -> DynamicVertexBuffer
	SetDefaultIndexBuffer(DEFAULT_IB_FILL_RECT);
	if (SetPDTStream(vertices, 4))
		STATEMANAGER.DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, 4, 0, 2);
	//OLD: STATEMANAGER.DrawIndexedPrimitiveUP(D3DPT_TRIANGLELIST, 0, 4, 2, &ms_fillRectIdxVector[0], D3DFMT_INDEX16, vertices, sizeof(TPDTVertex));
}


void CScreen::RenderBillboard(D3DXVECTOR3 * Position, D3DXCOLOR & Color)
{
	assert(ms_lpd3dDevice != NULL);

	TPDTVertex vertices[4];
	vertices[0].position = TPosition(Position[0].x, Position[0].y, Position[0].z);
	vertices[0].diffuse = Color;
	vertices[0].texCoord = TTextureCoordinate(0, 0);

	vertices[1].position = TPosition(Position[1].x, Position[1].y, Position[1].z);
	vertices[1].diffuse = Color;
	vertices[1].texCoord = TTextureCoordinate(1, 0);

	vertices[2].position = TPosition(Position[2].x, Position[2].y, Position[2].z);
	vertices[2].diffuse = Color;
	vertices[2].texCoord = TTextureCoordinate(0, 1);

	vertices[3].position = TPosition(Position[3].x, Position[3].y, Position[3].z);
	vertices[3].diffuse = Color;
	vertices[3].texCoord = TTextureCoordinate(1, 1);

	STATEMANAGER.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);

	// 2004.11.18.myevan.DrawIndexPrimitiveUP -> DynamicVertexBuffer
	SetDefaultIndexBuffer(DEFAULT_IB_FILL_RECT);
	if (SetPDTStream(vertices, 4))
		STATEMANAGER.DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, 4, 0, 2);
	//OLD: STATEMANAGER.DrawIndexedPrimitiveUP(D3DPT_TRIANGLELIST, 0, 4, 2, &ms_fillRectIdxVector[0], D3DFMT_INDEX16, vertices, sizeof(TPDTVertex));
}

void CScreen::DrawMinorGrid(float xMin, float yMin, float xMax, float yMax, float xminorStep, float yminorStep, float zPos)
{
	float x, y;

	for (y = yMin; y <= yMax; y += yminorStep)
		RenderLine2d(xMin, y, xMax, y, zPos);

	for (x = xMin; x <= xMax; x += xminorStep)
		RenderLine2d(x, yMin, x, yMax, zPos);
}

void CScreen::DrawGrid(float xMin, float yMin, float xMax, float yMax, float xmajorStep, float ymajorStep, float xminorStep, float yminorStep, float zPos)
{
	xMin*=xminorStep;
	xMax*=xminorStep;
	yMin*=yminorStep;
	yMax*=yminorStep;
	xmajorStep*=xminorStep;
	ymajorStep*=yminorStep;

	float x, y;

	SetDiffuseColor(0.5f, 0.5f, 0.5f);
	DrawMinorGrid(xMin, yMin, xMax, yMax, xminorStep, yminorStep, zPos);

	SetDiffuseColor(0.7f, 0.7f, 0.7f);
	for (y = 0.0f; y >= yMin; y -= ymajorStep)
		RenderLine2d(xMin, y, xMax, y, zPos);

	for (y = 0.0f; y <= yMax; y += ymajorStep)
		RenderLine2d(xMin, y, xMax, y, zPos);

	for (x = 0.0f; x >= xMin; x -= xmajorStep)
		RenderLine2d(x, yMin, x, yMax, zPos);

	for (x = 0.0f; x <= yMax; x += xmajorStep)
		RenderLine2d(x, yMin, x, yMax, zPos);

	SetDiffuseColor(1.0f, 1.0f, 1.0f);
	RenderLine2d(xMin, 0.0f, xMax, 0.0f, zPos);
	RenderLine2d(0.0f, yMin, 0.0f, yMax, zPos);
}

void CScreen::SetCursorPosition(int x, int y, int hres, int vres)
{
	D3DXVECTOR3 v;
	v.x = -(((2.0f * x) / hres) - 1) / ms_matProj._11;
	v.y = (((2.0f * y) / vres) - 1) / ms_matProj._22;
	v.z = 1.0f;

    D3DXMATRIX matViewInverse=ms_matInverseView;
    //D3DXMatrixInverse(&matViewInverse, NULL, &ms_matView);

    ms_vtPickRayDir.x = v.x * matViewInverse._11 +
						v.y * matViewInverse._21 +
						v.z * matViewInverse._31;

    ms_vtPickRayDir.y = v.x * matViewInverse._12 +
						v.y * matViewInverse._22 +
						v.z * matViewInverse._32;

    ms_vtPickRayDir.z = v.x * matViewInverse._13 +
						v.y * matViewInverse._23 +
						v.z * matViewInverse._33;

    ms_vtPickRayOrig.x = matViewInverse._41;
    ms_vtPickRayOrig.y = matViewInverse._42;
    ms_vtPickRayOrig.z = matViewInverse._43;

	ms_Ray.SetStartPoint(ms_vtPickRayOrig);
	ms_Ray.SetDirection(-ms_vtPickRayDir, 51200.0f);
}

bool CScreen::GetCursorPosition(float* px, float* py, float* pz)
{
	if (!GetCursorXYPosition(px, py)) return false;
	if (!GetCursorZPosition(pz)) return false;

	return true;
}

bool CScreen::GetCursorXYPosition(float* px, float* py)
{
	D3DXVECTOR3 v3Eye = CCameraManager::Instance().GetCurrentCamera()->GetEye();

	TPosition posVertices[4];
	posVertices[0] = TPosition(v3Eye.x-90000000.0f, v3Eye.y+90000000.0f, 0.0f);
	posVertices[1] = TPosition(v3Eye.x-90000000.0f, v3Eye.y-90000000.0f, 0.0f);
	posVertices[2] = TPosition(v3Eye.x+90000000.0f, v3Eye.y+90000000.0f, 0.0f);
	posVertices[3] = TPosition(v3Eye.x+90000000.0f, v3Eye.y-90000000.0f, 0.0f);

	static const WORD sc_awFillRectIndices[6] = { 0, 2, 1, 2, 3, 1, };

	float u, v, t;
	for (int i = 0; i < 2; ++i)
	{
		if (IntersectTriangle(ms_vtPickRayOrig, ms_vtPickRayDir,
							 posVertices[sc_awFillRectIndices[i*3+0]],
							 posVertices[sc_awFillRectIndices[i*3+1]],
							 posVertices[sc_awFillRectIndices[i*3+2]],
							 &u, &v, &t))
		{
			*px = ms_vtPickRayOrig.x + ms_vtPickRayDir.x * t;
			*py = ms_vtPickRayOrig.y + ms_vtPickRayDir.y * t;
			return true;
		}
	}
	return false;
}

bool CScreen::GetCursorZPosition(float* pz)
{
	D3DXVECTOR3 v3Eye = CCameraManager::Instance().GetCurrentCamera()->GetEye();

	TPosition posVertices[4];
	posVertices[0] = TPosition(v3Eye.x-90000000.0f, 0.0f, v3Eye.z+90000000.0f);
	posVertices[1] = TPosition(v3Eye.x-90000000.0f, 0.0f, v3Eye.z-90000000.0f);
	posVertices[2] = TPosition(v3Eye.x+90000000.0f, 0.0f, v3Eye.z+90000000.0f);
	posVertices[3] = TPosition(v3Eye.x+90000000.0f, 0.0f, v3Eye.z-90000000.0f);

	static const WORD sc_awFillRectIndices[6] = { 0, 2, 1, 2, 3, 1, };

	float u, v, t;
	for (int i = 0; i < 2; ++i)
	{
		if (IntersectTriangle(ms_vtPickRayOrig, ms_vtPickRayDir,
							 posVertices[sc_awFillRectIndices[i*3+0]],
							 posVertices[sc_awFillRectIndices[i*3+1]],
							 posVertices[sc_awFillRectIndices[i*3+2]],
							 &u, &v, &t))
		{
			*pz = ms_vtPickRayOrig.z + ms_vtPickRayDir.z * t;
			return true;
		}
	}
	return false;
}

void CScreen::GetPickingPosition(float t, float* x, float* y, float* z)
{
	*x = ms_vtPickRayOrig.x + ms_vtPickRayDir.x * t;
	*y = ms_vtPickRayOrig.y + ms_vtPickRayDir.y * t;
	*z = ms_vtPickRayOrig.z + ms_vtPickRayDir.z * t;
}

void CScreen::SetDiffuseColor(DWORD diffuseColor)
{
	ms_diffuseColor = diffuseColor;
}

void CScreen::SetDiffuseColor(float r, float g, float b, float a)
{
	ms_diffuseColor = GetColor(r, g, b, a);
}

void CScreen::SetClearColor(float r, float g, float b, float a)
{
	ms_clearColor = GetColor(r, g, b, a);
}

void CScreen::SetClearDepth(float depth)
{
	ms_clearDepth = depth;
}

void CScreen::SetClearStencil(DWORD stencil)
{
	ms_clearStencil = stencil;
}

void CScreen::ClearDepthBuffer()
{
	assert(ms_lpd3dDevice != NULL);
	ms_lpd3dDevice->Clear(0L, NULL, D3DCLEAR_ZBUFFER, ms_clearColor, ms_clearDepth, ms_clearStencil);
}

void CScreen::Clear()
{
	assert(ms_lpd3dDevice != NULL);
	ms_lpd3dDevice->Clear(0L, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER, ms_clearColor, ms_clearDepth, ms_clearStencil);
}

BOOL CScreen::IsLostDevice()
{
	if (!ms_lpd3dDevice)
		return TRUE;

	IDirect3DDevice8 & rkD3DDev = *ms_lpd3dDevice;
	HRESULT hrTestCooperativeLevel = rkD3DDev.TestCooperativeLevel();
	if (FAILED(hrTestCooperativeLevel))
		return TRUE;

	return FALSE;
}

BOOL CScreen::RestoreDevice()
{
	if (!ms_lpd3dDevice)
		return FALSE;

	UINT iD3DAdapterInfo = ms_iD3DAdapterInfo;
	IDirect3D8 & rkD3D = *ms_lpd3d;
	IDirect3DDevice8 & rkD3DDev = *ms_lpd3dDevice;
	D3DPRESENT_PARAMETERS & rkD3DPP = ms_d3dPresentParameter;
	D3D_CDisplayModeAutoDetector & rkD3DDetector = ms_kD3DDetector;

	HRESULT hrTestCooperativeLevel = rkD3DDev.TestCooperativeLevel();

	if (FAILED(hrTestCooperativeLevel))
	{
		if (D3DERR_DEVICELOST == hrTestCooperativeLevel)
		{
			return FALSE;
		}

		if (D3DERR_DEVICENOTRESET == hrTestCooperativeLevel)
		{
			D3D_CAdapterInfo* pkD3DAdapterInfo = rkD3DDetector.GetD3DAdapterInfop(ms_iD3DAdapterInfo);

			if (!pkD3DAdapterInfo)
				return FALSE;

			D3DDISPLAYMODE & rkD3DDMDesktop = pkD3DAdapterInfo->GetDesktopD3DDisplayModer();

			if (FAILED(rkD3D.GetAdapterDisplayMode(iD3DAdapterInfo, &rkD3DDMDesktop)))
				return FALSE;

			rkD3DPP.BackBufferFormat = rkD3DDMDesktop.Format;

			HRESULT hrReset = rkD3DDev.Reset(&rkD3DPP);

			if (FAILED(hrReset))
			{
				return FALSE;
			}

			STATEMANAGER.SetDefaultState();
		}
	}

	return TRUE;

}

bool CScreen::Begin()
{
	assert(ms_lpd3dDevice != NULL);
	ResetFaceCount();

	if (!STATEMANAGER.BeginScene())
	{
		Tracenf("BeginScene FAILED\n");
		return false;
	}

	return true;
}

void CScreen::End()
{
	STATEMANAGER.EndScene();
}

extern bool g_isBrowserMode;
extern RECT g_rcBrowser;

void CScreen::Show(HWND hWnd)
{
	assert(ms_lpd3dDevice != NULL);

	if (g_isBrowserMode)
	{
		RECT rcTop={0, 0, ms_d3dPresentParameter.BackBufferWidth, g_rcBrowser.top};
		RECT rcBottom={0, g_rcBrowser.bottom, ms_d3dPresentParameter.BackBufferWidth, ms_d3dPresentParameter.BackBufferHeight};
		RECT rcLeft={0, g_rcBrowser.top, g_rcBrowser.left, g_rcBrowser.bottom};
		RECT rcRight={g_rcBrowser.right, g_rcBrowser.top, ms_d3dPresentParameter.BackBufferWidth, g_rcBrowser.bottom};

		ms_lpd3dDevice->Present(&rcTop, &rcTop, hWnd, NULL);
		ms_lpd3dDevice->Present(&rcBottom, &rcBottom, hWnd, NULL);
		ms_lpd3dDevice->Present(&rcLeft, &rcLeft, hWnd, NULL);
		ms_lpd3dDevice->Present(&rcRight, &rcRight, hWnd, NULL);
	}
	else
	{
		HRESULT hr=ms_lpd3dDevice->Present(NULL, NULL, hWnd, NULL);
		if (D3DERR_DEVICELOST == hr)
			RestoreDevice();
	}
}

void CScreen::Show(RECT * pSrcRect)
{
	assert(ms_lpd3dDevice != NULL);
	ms_lpd3dDevice->Present(pSrcRect, NULL, NULL, NULL);
}

void CScreen::Show(RECT * pSrcRect, HWND hWnd)
{
	assert(ms_lpd3dDevice != NULL);
	ms_lpd3dDevice->Present(pSrcRect, NULL, hWnd, NULL);
}

void CScreen::ProjectPosition(float x, float y, float z, float * pfX, float * pfY)
{
	D3DXVECTOR3 Input(x, y, z);
	D3DXVECTOR3 Output;
	D3DXVec3Project(&Output, &Input, &ms_Viewport, &ms_matProj, &ms_matView, &ms_matWorld);

	*pfX = Output.x;
	*pfY = Output.y;
}

void CScreen::ProjectPosition(float x, float y, float z, float * pfX, float * pfY, float * pfZ)
{
	D3DXVECTOR3 Input(x, y, z);
	D3DXVECTOR3 Output;
	D3DXVec3Project(&Output, &Input, &ms_Viewport, &ms_matProj, &ms_matView, &ms_matWorld);

	*pfX = Output.x;
	*pfY = Output.y;
	*pfZ = Output.z;
}

void CScreen::UnprojectPosition(float x, float y, float z, float * pfX, float * pfY, float * pfZ)
{
	D3DXVECTOR3 Input(x, y, z);
	D3DXVECTOR3 Output;
	D3DXVec3Unproject(&Output, &Input, &ms_Viewport, &ms_matProj, &ms_matView, &ms_matWorld);

	*pfX = Output.x;
	*pfY = Output.y;
	*pfZ = Output.z;
}

void CScreen::SetColorOperation()
{
	STATEMANAGER.SetTexture(0, NULL);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG1,	D3DTA_DIFFUSE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLOROP,	D3DTOP_SELECTARG1);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_ALPHAOP,	D3DTOP_DISABLE);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_COLOROP,	D3DTOP_DISABLE);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_ALPHAOP,	D3DTOP_DISABLE);
}

void CScreen::SetDiffuseOperation()
{
	STATEMANAGER.SetTexture(0, NULL);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG1,	D3DTA_TEXTURE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG2,	D3DTA_DIFFUSE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLOROP,	D3DTOP_MODULATE);

	STATEMANAGER.SetTextureStageState(1, D3DTSS_COLOROP,	D3DTOP_DISABLE);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_ALPHAOP,	D3DTOP_DISABLE);
}

void CScreen::SetBlendOperation()
{
	STATEMANAGER.SetTexture(0, NULL);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG1,	D3DTA_TEXTURE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG2,	D3DTA_CURRENT);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLOROP,	D3DTOP_MODULATE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_ALPHAARG1,	D3DTA_TEXTURE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_ALPHAARG2,	D3DTA_CURRENT);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_ALPHAOP,	D3DTOP_MODULATE);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_COLOROP,	D3DTOP_DISABLE);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_ALPHAOP,	D3DTOP_DISABLE);
}

void CScreen::SetOneColorOperation(D3DXCOLOR & rColor)
{
	STATEMANAGER.SetTexture(0, NULL);
	STATEMANAGER.SetTexture(1, NULL);

	STATEMANAGER.SetRenderState(D3DRS_TEXTUREFACTOR, rColor);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TFACTOR);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1);
}

void CScreen::SetAddColorOperation(D3DXCOLOR & rColor)
{
	STATEMANAGER.SetRenderState(D3DRS_TEXTUREFACTOR, rColor);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_TFACTOR);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_ADD);
}

void CScreen::Identity()
{
	STATEMANAGER.SetTransform(D3DTS_WORLD, &ms_matIdentity);
}

CScreen::CScreen()
{
}

CScreen::~CScreen()
{
}
//void BuildViewFrustum() { ms_frustum.BuildViewFrustum(ms_matView*ms_matProj); }

void CScreen::BuildViewFrustum()
{
	const D3DXVECTOR3& c_rv3Eye=CCameraManager::Instance().GetCurrentCamera()->GetEye();
	const D3DXVECTOR3& c_rv3View=CCameraManager::Instance().GetCurrentCamera()->GetView();
	 ms_frustum.BuildViewFrustum2(
		 ms_matView*ms_matProj,
		 ms_fNearY,
		 ms_fFarY,
		 ms_fFieldOfView,
		 ms_fAspect,
		 c_rv3Eye, c_rv3View);
}