import ui
import net
import grp
import snd
import item
import acce
import player
import uiToolTip
import localeInfo
import uiInventory
import mouseModule
import uiScriptLocale

class CombineWindow(ui.ScriptWindow):
	def __init__(self):
		ui.ScriptWindow.__init__(self)
		self.isLoaded = 0
		self.PositionOut = 0
		self.PositionStartX = 0
		self.PositionStartY = 0

	def __del__(self):
		ui.ScriptWindow.__del__(self)

	def Destroy(self):
		self.ClearAllSlots()
		self.ClearDictionary()
		self.titleBar = None
		self.btnAccept = None
		self.btnCancel = None
		self.acceSlot = None
		self.needMoney = None
		self.Result = None
		self.PositionOut = 0
		self.PositionStartX = 0
		self.PositionStartY = 0

	def LoadWindow(self):
		if self.isLoaded:
			return

		self.isLoaded = 1

		try:
			pyScrLoader = ui.PythonScriptLoader()
			pyScrLoader.LoadScriptFile(self, "uiscript/acce_combinewindow.py")

		except:
			import exception
			exception.Abort("Acce_CombineWindow.LoadDialog.LoadScript")

		try:
			self.titleBar = self.GetChild("TitleBar")
			self.btnAccept = self.GetChild("AcceptButton")
			self.btnCancel = self.GetChild("CancelButton")
			self.needMoney = self.GetChild("NeedMoney")
			self.Result = self.GetChild("Result")
			self.acceSlot = self.GetChild("AcceSlot")
		except:
			import exception
			exception.Abort("Acce_CombineWindow.LoadDialog.BindObject")

		self.acceSlot.SetSelectEmptySlotEvent(ui.__mem_func__(self.OnSelectEmptySlot))
		self.acceSlot.SetUnselectItemSlotEvent(ui.__mem_func__(self.OnSelectItemSlot))
		self.acceSlot.SetUseSlotEvent(ui.__mem_func__(self.OnSelectItemSlot))
		self.acceSlot.SetOverInItemEvent(ui.__mem_func__(self.OnOverInItem))
		self.acceSlot.SetOverOutItemEvent(ui.__mem_func__(self.OnOverOutItem))
		self.titleBar.SetCloseEvent(ui.__mem_func__(self.OnClose))
		self.btnCancel.SetEvent(ui.__mem_func__(self.OnClose))
		self.btnAccept.SetEvent(ui.__mem_func__(self.OnAccept))
		self.tooltipItem = None

	def SetItemToolTip(self, itemTooltip):
		self.tooltipItem = itemTooltip

	def IsOpened(self):
		if self.IsShow() and self.isLoaded:
			return True

		return False

	def ClearAllSlots(self):
		acce.Clear()
		if self.acceSlot:
			for i in xrange(acce.WINDOW_MAX_MATERIALS + 1):
				self.acceSlot.ClearSlot(i)

	def Open(self):
		self.PositionOut = 0
		(self.PositionStartX, self.PositionStartY, z) = player.GetMainCharacterPosition()
		self.needMoney.SetText(localeInfo.ACCE_REFINE_COST % (acce.GetPrice()))
		self.ClearAllSlots()
		self.SetCenterPosition()
		self.Show()

	def Close(self):
		if self.tooltipItem:
			self.tooltipItem.HideToolTip()

		self.Hide()

	def OnClose(self):
		acce.SendCloseRequest()

	def OnPressEscapeKey(self):
		self.OnClose()
		return True

	def OnAccept(self):
		acce.SendRefineRequest()

	def OnUpdate(self):
		LIMIT_RANGE = acce.LIMIT_RANGE
		(x, y, z) = player.GetMainCharacterPosition()
		if abs(x - self.PositionStartX) >= LIMIT_RANGE or abs(y - self.PositionStartY) >= LIMIT_RANGE:
			if not self.PositionOut:
				self.PositionOut += 1
				self.OnClose()

	def OnSelectEmptySlot(self, selectedSlotPos):
		isAttached = mouseModule.mouseController.isAttached()
		if not isAttached or selectedSlotPos == acce.WINDOW_MAX_MATERIALS:
			return

		attachedSlotType = mouseModule.mouseController.GetAttachedType()
		attachedSlotPos = mouseModule.mouseController.GetAttachedSlotNumber()
		attachedInvenType = player.SlotTypeToInvenType(attachedSlotType)
		mouseModule.mouseController.DeattachObject()
		if attachedSlotType == player.SLOT_TYPE_INVENTORY and attachedInvenType == player.INVENTORY:
			acce.Add(attachedInvenType, attachedSlotPos, selectedSlotPos)

	def OnSelectItemSlot(self, selectedSlotPos):
		if selectedSlotPos == acce.WINDOW_MAX_MATERIALS:
			return

		mouseModule.mouseController.DeattachObject()
		acce.Remove(selectedSlotPos)

	def OnOverInItem(self, selectedSlotPos):
		if self.tooltipItem:
			if selectedSlotPos == acce.WINDOW_MAX_MATERIALS:
				(isHere, iCell) = acce.GetAttachedItem(0)
				if isHere:
					self.tooltipItem.SetAcceResultItem(iCell)
			else:
				(isHere, iCell) = acce.GetAttachedItem(selectedSlotPos)
				if isHere:
					self.tooltipItem.SetInventoryItem(iCell)

	def OnOverOutItem(self):
		if self.tooltipItem:
			self.tooltipItem.HideToolTip()

	def Refresh(self, iAct):
		self.needMoney.SetText(localeInfo.ACCE_REFINE_COST % (acce.GetPrice()))
		self.acceSlot.ClearSlot(acce.WINDOW_MAX_MATERIALS)
		for i in xrange(acce.WINDOW_MAX_MATERIALS):
			self.acceSlot.ClearSlot(i)
			(isHere, iCell) = acce.GetAttachedItem(i)
			if isHere:
				self.acceSlot.SetItemSlot(i, player.GetItemIndex(iCell), 0)
				if i == int(acce.WINDOW_MAX_MATERIALS - 1):
					(itemVnum, MinAbs, MaxAbs) = acce.GetResultItem()
					if not itemVnum:
						break

					self.acceSlot.SetItemSlot(i + 1, itemVnum, 0)
					break

class AbsorbWindow(ui.ScriptWindow):
	def __init__(self):
		ui.ScriptWindow.__init__(self)
		self.isLoaded = 0
		self.PositionOut = 0
		self.PositionStartX = 0
		self.PositionStartY = 0

	def __del__(self):
		ui.ScriptWindow.__del__(self)

	def Destroy(self):
		self.ClearDictionary()
		self.titleBar = None
		self.btnAccept = None
		self.btnCancel = None
		self.acceSlot = None
		self.PositionOut = 0
		self.PositionStartX = 0
		self.PositionStartY = 0

	def LoadWindow(self):
		if self.isLoaded:
			return

		self.isLoaded = 1

		try:
			pyScrLoader = ui.PythonScriptLoader()
			pyScrLoader.LoadScriptFile(self, "uiscript/acce_absorbwindow.py")

		except:
			import exception
			exception.Abort("Acce_AbsorbtionWindow.LoadDialog.LoadScript")

		try:
			self.titleBar = self.GetChild("TitleBar")
			self.btnAccept = self.GetChild("AcceptButton")
			self.btnCancel = self.GetChild("CancelButton")
			self.acceSlot = self.GetChild("AcceSlot")
		except:
			import exception
			exception.Abort("Acce_AbsorbtionWindow.LoadDialog.BindObject")

		self.acceSlot.SetSelectEmptySlotEvent(ui.__mem_func__(self.OnSelectEmptySlot))
		self.acceSlot.SetUnselectItemSlotEvent(ui.__mem_func__(self.OnSelectItemSlot))
		self.acceSlot.SetUseSlotEvent(ui.__mem_func__(self.OnSelectItemSlot))
		self.acceSlot.SetOverInItemEvent(ui.__mem_func__(self.OnOverInItem))
		self.acceSlot.SetOverOutItemEvent(ui.__mem_func__(self.OnOverOutItem))
		self.titleBar.SetCloseEvent(ui.__mem_func__(self.OnClose))
		self.btnCancel.SetEvent(ui.__mem_func__(self.OnClose))
		self.btnAccept.SetEvent(ui.__mem_func__(self.OnAccept))

		self.tooltipItem = None

	def SetItemToolTip(self, itemTooltip):
		self.tooltipItem = itemTooltip

	def IsOpened(self):
		if self.IsShow() and self.isLoaded:
			return True

		return False

	def Open(self):
		self.PositionOut = 0
		(self.PositionStartX, self.PositionStartY, z) = player.GetMainCharacterPosition()
		for i in xrange(acce.WINDOW_MAX_MATERIALS + 1):
			self.acceSlot.ClearSlot(i)
		self.SetCenterPosition()
		self.Show()

	def Close(self):
		if self.tooltipItem:
			self.tooltipItem.HideToolTip()

		self.Hide()

	def OnClose(self):
		acce.SendCloseRequest()

	def OnPressEscapeKey(self):
		self.OnClose()
		return True

	def OnAccept(self):
		acce.SendRefineRequest()

	def OnUpdate(self):
		LIMIT_RANGE = acce.LIMIT_RANGE
		(x, y, z) = player.GetMainCharacterPosition()
		if abs(x - self.PositionStartX) >= LIMIT_RANGE or abs(y - self.PositionStartY) >= LIMIT_RANGE:
			if not self.PositionOut:
				self.PositionOut += 1
				self.OnClose()

	def OnSelectEmptySlot(self, selectedSlotPos):
		isAttached = mouseModule.mouseController.isAttached()
		if not isAttached or selectedSlotPos == acce.WINDOW_MAX_MATERIALS:
			return

		attachedSlotType = mouseModule.mouseController.GetAttachedType()
		attachedSlotPos = mouseModule.mouseController.GetAttachedSlotNumber()
		attachedInvenType = player.SlotTypeToInvenType(attachedSlotType)
		mouseModule.mouseController.DeattachObject()
		if attachedSlotType == player.SLOT_TYPE_INVENTORY and attachedInvenType == player.INVENTORY:
			acce.Add(attachedInvenType, attachedSlotPos, selectedSlotPos)

	def OnSelectItemSlot(self, selectedSlotPos):
		if selectedSlotPos == acce.WINDOW_MAX_MATERIALS:
			return

		mouseModule.mouseController.DeattachObject()
		acce.Remove(selectedSlotPos)

	def OnOverInItem(self, selectedSlotPos):
		if self.tooltipItem:
			if selectedSlotPos == acce.WINDOW_MAX_MATERIALS:
				(isHere1, iCell1) = acce.GetAttachedItem(0)
				(isHere2, iCell2) = acce.GetAttachedItem(1)
				if isHere1 and isHere2:
					self.tooltipItem.SetAcceResultAbsItem(iCell1, iCell2)
			else:
				(isHere, iCell) = acce.GetAttachedItem(selectedSlotPos)
				if isHere:
					self.tooltipItem.SetInventoryItem(iCell)

	def OnOverOutItem(self):
		if self.tooltipItem:
			self.tooltipItem.HideToolTip()

	def Refresh(self, iAct):
		self.acceSlot.ClearSlot(acce.WINDOW_MAX_MATERIALS)
		for i in xrange(acce.WINDOW_MAX_MATERIALS):
			self.acceSlot.ClearSlot(i)
			(isHere, iCell) = acce.GetAttachedItem(i)
			if isHere:
				self.acceSlot.SetItemSlot(i, player.GetItemIndex(iCell), 0)
				if i == int(acce.WINDOW_MAX_MATERIALS - 1):
					(itemVnum, MinAbs, MaxAbs) = acce.GetResultItem()
					if not itemVnum:
						break

					self.acceSlot.SetItemSlot(i + 1, itemVnum, 0)
					break

