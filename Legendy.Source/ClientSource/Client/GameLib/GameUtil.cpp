#include "StdAfx.h"
#include "../eterLib/lineintersect_utils.h"

#include "GameUtil.h"

bool DetectCollisionDynamicZCylinderVSDynamicZCylinder(const CDynamicSphereInstance & c_rSphere1, const CDynamicSphereInstance & c_rSphere2)
{
	CDynamicSphereInstance c_rCylinder1=c_rSphere1;
	CDynamicSphereInstance c_rCylinder2=c_rSphere2;

	c_rCylinder1.v3Position.z=0;
	c_rCylinder1.v3LastPosition.z=0;

	c_rCylinder2.v3Position.z=0;
	c_rCylinder2.v3LastPosition.z=0;

	float r = c_rCylinder1.fRadius+c_rCylinder2.fRadius;
	float rsq = r*r;

	// AABB check
	D3DXVECTOR3 mi1=c_rCylinder1.v3LastPosition, mi2 = c_rCylinder1.v3Position;
	D3DXVECTOR3 mi3=c_rCylinder2.v3LastPosition, mi4 = c_rCylinder2.v3Position;
	if (mi1.x>mi2.x) std::swap(mi1.x,mi2.x);
	if (mi1.y>mi2.y) std::swap(mi1.y,mi2.y);
	if (mi1.z>mi2.z) std::swap(mi1.z,mi2.z);
	if (mi3.x>mi4.x) std::swap(mi3.x,mi4.x);
	if (mi3.y>mi4.y) std::swap(mi3.y,mi4.y);
	if (mi3.z>mi4.z) std::swap(mi3.z,mi4.z);
	mi1.x -= c_rCylinder1.fRadius; mi1.y -= c_rCylinder1.fRadius; mi1.z -= c_rCylinder1.fRadius;
	mi2.x += c_rCylinder1.fRadius; mi2.y += c_rCylinder1.fRadius; mi2.z += c_rCylinder1.fRadius;
	mi3.x -= c_rCylinder2.fRadius; mi3.y -= c_rCylinder2.fRadius; mi3.z -= c_rCylinder2.fRadius;
	mi4.x += c_rCylinder2.fRadius; mi4.y += c_rCylinder2.fRadius; mi4.z += c_rCylinder2.fRadius;
	if (mi4.x<mi1.x || mi2.x<mi3.x) return false;
	if (mi4.y<mi1.y || mi2.y<mi3.y) return false;
	if (mi4.z<mi1.z || mi2.z<mi3.z) return false;

	D3DXVECTOR3 vA, vB;
	IntersectLineSegments(c_rCylinder1.v3LastPosition, c_rCylinder1.v3Position,
		c_rCylinder2.v3LastPosition, c_rCylinder2.v3Position,
		vA, vB);
	return (D3DXVec3LengthSq(&(vA-vB))<=rsq);
}

bool DetectCollisionDynamicSphereVSDynamicSphere(const CDynamicSphereInstance & c_rSphere1, const CDynamicSphereInstance & c_rSphere2)
{
	float r = c_rSphere1.fRadius+c_rSphere2.fRadius;
	float rsq = r*r;

	/*if (D3DXVec3LengthSq(&(c_rSphere1.v3Position		-c_rSphere2.v3Position		))<=rsq) return true;
	if (D3DXVec3LengthSq(&(c_rSphere1.v3Position		-c_rSphere2.v3LastPosition	))<=rsq) return true;
	if (D3DXVec3LengthSq(&(c_rSphere1.v3LastPosition	-c_rSphere2.v3Position		))<=rsq) return true;
	if (D3DXVec3LengthSq(&(c_rSphere1.v3LastPosition	-c_rSphere2.v3LastPosition	))<=rsq) return true;*/


	//*/
	// using gpg line-collision

	// AABB check

	D3DXVECTOR3 mi1=c_rSphere1.v3LastPosition, mi2 = c_rSphere1.v3Position;
	D3DXVECTOR3 mi3=c_rSphere2.v3LastPosition, mi4 = c_rSphere2.v3Position;
	if (mi1.x>mi2.x) std::swap(mi1.x,mi2.x);
	if (mi1.y>mi2.y) std::swap(mi1.y,mi2.y);
	if (mi1.z>mi2.z) std::swap(mi1.z,mi2.z);
	if (mi3.x>mi4.x) std::swap(mi3.x,mi4.x);
	if (mi3.y>mi4.y) std::swap(mi3.y,mi4.y);
	if (mi3.z>mi4.z) std::swap(mi3.z,mi4.z);
	mi1.x -= c_rSphere1.fRadius; mi1.y -= c_rSphere1.fRadius; mi1.z -= c_rSphere1.fRadius;
	mi2.x += c_rSphere1.fRadius; mi2.y += c_rSphere1.fRadius; mi2.z += c_rSphere1.fRadius;
	mi3.x -= c_rSphere2.fRadius; mi3.y -= c_rSphere2.fRadius; mi3.z -= c_rSphere2.fRadius;
	mi4.x += c_rSphere2.fRadius; mi4.y += c_rSphere2.fRadius; mi4.z += c_rSphere2.fRadius;
	if (mi4.x<mi1.x || mi2.x<mi3.x) return false;
	if (mi4.y<mi1.y || mi2.y<mi3.y) return false;
	if (mi4.z<mi1.z || mi2.z<mi3.z) return false;

	D3DXVECTOR3 vA, vB;/*
	IntersectLineSegments(
		c_rSphere1.v3LastPosition.x,c_rSphere1.v3LastPosition.y,c_rSphere1.v3LastPosition.z,
		c_rSphere1.v3Position.x,	c_rSphere1.v3Position.y,	c_rSphere1.v3Position.z,
		c_rSphere2.v3LastPosition.x,c_rSphere2.v3LastPosition.y,c_rSphere2.v3LastPosition.z,
		c_rSphere2.v3Position.x,	c_rSphere2.v3Position.y,	c_rSphere2.v3Position.z,
		false, 1.e-1f, vA.x, vA.y, vA.z, vB.x, vB.y, vB.z);*/
	IntersectLineSegments(c_rSphere1.v3LastPosition, c_rSphere1.v3Position,
		c_rSphere2.v3LastPosition, c_rSphere2.v3Position,
		vA, vB);
	return (D3DXVec3LengthSq(&(vA-vB))<=rsq);
	//*/


}

/*
// Dynamic VS Static
bool DetectCollisionDynamicSphereVSStaticPlane(const CDynamicSphereInstance & c_rSphere, const TPlaneData & c_rPlane)
{
	D3DXVECTOR3 v3SpherePosition = c_rSphere.v3Position - c_rPlane.v3Position;
	D3DXVECTOR3 v3SphereLastPosition = c_rSphere.v3LastPosition - c_rPlane.v3Position;

	float fPosition1 = D3DXVec3Dot(&c_rPlane.v3Normal, &v3SpherePosition);
	float fPosition2 = D3DXVec3Dot(&c_rPlane.v3Normal, &v3SphereLastPosition);

	if (fPosition1 >0.0f && fPosition2 < 0.0f  || fPosition1 <0.0f && fPosition2 >0.0f || (fPosition1) <= c_rSphere.fRadius && fPosition1 >= -c_rSphere.fRadius)
	{
		D3DXVECTOR3 v3QuadPosition1 = c_rSphere.v3Position - c_rPlane.v3QuadPosition[0];
		D3DXVECTOR3 v3QuadPosition2 = c_rSphere.v3Position - c_rPlane.v3QuadPosition[3];
		if (D3DXVec3Dot(&v3QuadPosition1, &c_rPlane.v3InsideVector[0]) < c_rSphere.fRadius)
		if (D3DXVec3Dot(&v3QuadPosition1, &c_rPlane.v3InsideVector[1]) < c_rSphere.fRadius)
		if (D3DXVec3Dot(&v3QuadPosition2, &c_rPlane.v3InsideVector[2]) < c_rSphere.fRadius)
		if (D3DXVec3Dot(&v3QuadPosition2, &c_rPlane.v3InsideVector[3]) < c_rSphere.fRadius)
			return true;

	}

	return false;
}

bool DetectCollisionDynamicSphereVSStaticSphere(const CDynamicSphereInstance & c_rSphere, const TSphereData & c_rSphereData)
{
	D3DXVECTOR3 v3Distance = c_rSphere.v3Position - c_rSphereData.v3Position;
	float fDistanceSq = D3DXVec3LengthSq(&v3Distance);
	float fRadiusSummary = c_rSphere.fRadius + c_rSphereData.fRadius;
	if (fDistanceSq < fRadiusSummary*fRadiusSummary)
		return true;

	//D3DXVECTOR3 v3LastDistance = c_rSphere.v3LastPosition - c_rSphereData.v3Position;
	//if (D3DXVec3Dot(&v3LastDistance, &v3Distance) < 0.0f)
	//	return true;

	return false;
}

bool DetectCollisionDynamicSphereVSStaticCylinder(const CDynamicSphereInstance & c_rSphere, const TCylinderData & c_rCylinderData)
{
	if (c_rSphere.v3Position.z + c_rSphere.fRadius < c_rCylinderData.v3Position.z)
		return false;

	if (c_rSphere.v3Position.z - c_rSphere.fRadius > c_rCylinderData.v3Position.z + c_rCylinderData.fHeight)
		return false;

	D3DXVECTOR3 v3curDistance = c_rSphere.v3Position - c_rCylinderData.v3Position;
	float fDistance = D3DXVec3Length(&v3curDistance);

	if (fDistance <= c_rSphere.fRadius + c_rCylinderData.fRadius)
		return true;

	//D3DXVECTOR3 v3lastDistance = c_rSphere.v3LastPosition - c_rCylinderData.v3Position;

	//if (D3DXVec3Dot(&v3curDistance, &v3lastDistance) < 0.0f)
	//	return true;

	return false;
}
*/
/*
bool DetectCollisionDynamicSphereVSStaticBox(const TSphereInstance & c_rSphere, const TBoxData & c_rBoxData)
{
	return false;
}
*/
// Static VS Static
/*
bool DetectCollisionStaticSphereVSStaticSphere(const TSphereData & c_rSphere1, const TSphereData & c_rSphere2)
{
	D3DXVECTOR3 v3Distance = c_rSphere1.v3Position - c_rSphere2.v3Position;
	float fDistance = D3DXVec3Length(&v3Distance);

	if (fDistance < c_rSphere1.fRadius + c_rSphere2.fRadius)
		return true;

	return false;
}

bool DetectCollisionStaticSphereVSStaticCylinder(const TSphereData & c_rSphere, const TCylinderData & c_rCylinder)
{
	return false;
}
*/
/*bool DetectCollisionStaticSphereVSStaticBox(const TSphereData & c_rSphere, const TBoxData & c_rBox)
{
	return false;
}
*/
///////////////////////////////////////////////////////////////////////////////////////////////////

bool IsCWAcuteAngle(float begin, float end)
{
	return ((360.0f - begin + end) > (begin - end));
}

bool IsCCWAcuteAngle(float begin, float end)
{
	int fValue = abs((int) (360.0f - end + begin));
	return fValue >= (end - begin) ? true : false;
}

bool IsCWRotation(float begin, float end)
{
	return !IsCCWRotation(begin, end);
}

bool IsCCWRotation(float begin, float end)
{
	//     180
	// 270      90
	//      0
	//
	return (begin - end < 0);
}

float GetInterpolatedRotation(float begin, float end, float curRate)
{
	if (IsCCWRotation(begin, end))
	{
		if (IsCCWAcuteAngle(begin, end))
			return GetLinearInterpolation(begin, end, curRate);

		return (360.0f + GetLinearInterpolation(begin, end - 360.0f, curRate));
	}

	if (IsCWAcuteAngle(begin, end))
		return GetLinearInterpolation(begin, end, curRate);

	return GetLinearInterpolation(begin, end + 360.0f, curRate);
}

float GetDegreeFromPosition(float x, float y)
{
	D3DXVECTOR3 vtDir(floor(x), floor(y), 0.0f);
	D3DXVec3Normalize(&vtDir, &vtDir);

	D3DXVECTOR3 vtStan(0, -1, 0);
	float ret = D3DXToDegree(acosf(D3DXVec3Dot(&vtDir, &vtStan)));

	if (vtDir.x < 0.0f)
		ret = 360.0f - ret;

	return ret;
}

float GetDegreeFromPosition2(float sx, float sy, float ex, float ey)
{
	return GetDegreeFromPosition(ex - sx, ey - sy);
}

float GetDegreeDifference(float fSource, float fTarget)
{
	if (fSource < 180.0f)
	{
		if (fTarget < fSource)
			return fSource - fTarget;

		else if(fTarget - fSource > 180.0f)
			return (360.0f - (fTarget - fSource));

		return fTarget - fSource;
	}
	else
	{
		if (fTarget > fSource)
			return fTarget - fSource;

		else if (fSource - fTarget > 180.0f)
		{
			return (360.0f - (fSource - fTarget));
		}

		return fSource - fTarget;
	}
}
int GetRotatingDirection(float fSource, float fTarget)
{
	if (fSource < 180.0f)
	{
		if (fTarget < fSource)
			return DEGREE_DIRECTION_RIGHT;

		else if((360.0f - fTarget) + fSource < 180.0f)
			return DEGREE_DIRECTION_RIGHT;

		return DEGREE_DIRECTION_LEFT;
	}
	else
	{
		if (fTarget > fSource)
		{
			return DEGREE_DIRECTION_LEFT;
		}
		else if ((360.0f - fSource) + fTarget < 180.0f)
		{
			return DEGREE_DIRECTION_LEFT;
		}

		return DEGREE_DIRECTION_RIGHT;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////

float CameraRotationToCharacterRotation(float fCameraRotation)
{
	return fmod((540.0f - fCameraRotation), 360.0f);
}

float CharacterRotationToCameraRotation(float fCharacterRotation)
{
	return fmod((540.0f - fCharacterRotation), 360.0f);
}

/*
bool DetectCollisionDynamicSphereVSStaticPlane(const TSphereInstance & c_rSphere, const TPlaneData & c_rPlane)
{
	D3DXVECTOR3 v3SpherePosition = c_rSphere.v3Position - c_rPlane.v3Position;
	D3DXVECTOR3 v3SphereLastPosition = c_rSphere.v3LastPosition - c_rPlane.v3Position;

	float fPosition1 = D3DXVec3Dot(&c_rPlane.v3Normal, &v3SpherePosition);
	float fPosition2 = D3DXVec3Dot(&c_rPlane.v3Normal, &v3SphereLastPosition);

	if (fPosition1 * fPosition2 < 0.0f || fabs(fPosition1) <= c_rSphere.fRadius)
	{
		float fT = -fPosition1 / D3DXVec3Dot(&c_rPlane.v3Normal, &c_rSphere.v3Advance);
		D3DXVECTOR3 v3CollisionPosition = c_rSphere.v3LastPosition + c_rSphere.v3Advance * fT;
		D3DXVECTOR3 v3QuadPosition1 = v3CollisionPosition - c_rPlane.v3BeginPosition;
		D3DXVECTOR3 v3QuadPosition2 = v3CollisionPosition - c_rPlane.v3EndPosition;
		D3DXVec3Normalize(&v3QuadPosition1, &v3QuadPosition1);
		D3DXVec3Normalize(&v3QuadPosition2, &v3QuadPosition2);

		if (D3DXVec3Dot(&v3QuadPosition1, &c_rPlane.v3InsideVector[0]) < 0.0f)
		if (D3DXVec3Dot(&v3QuadPosition1, &c_rPlane.v3InsideVector[1]) < 0.0f)
		if (D3DXVec3Dot(&v3QuadPosition2, &c_rPlane.v3InsideVector[2]) < 0.0f)
		if (D3DXVec3Dot(&v3QuadPosition2, &c_rPlane.v3InsideVector[3]) < 0.0f)
		{
			return true;
		}
	}

	return false;
}
*/
