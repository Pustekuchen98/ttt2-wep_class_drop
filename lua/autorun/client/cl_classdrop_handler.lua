-- target ID
hook.Add("TTTRenderEntityInfo", "ttt2_class_drop_render_entity_info", function(tData)
	local client = LocalPlayer()
	local ent = tData:GetEntity()

	if not IsValid(client) or not client:IsTerror() or not client:Alive() then return end
	if tData:GetEntityDistance() > 100 or not IsValid(ent) or ent:GetClass() ~= "tttc_classdrop" then return end

	local hd = CLASS.GetClassDataByIndex(ent:GetNWInt("customClass"))
	local pName = hd and CLASS.GetClassTranslation(hd) or ""

	-- enable targetID rendering
	tData:EnableText()
	tData:EnableOutline()
	tData:SetOutlineColor(client:GetRoleColor())

	tData:SetTitle(LANG.GetParamTranslation("ttt_class_title", {class = pName}))
	tData:SetSubtitle(LANG.GetParamTranslation("ttt_pickup_class", {usekey = Key("+use", "USE")}))
	tData:SetKeyBinding("+use")

	-- add class description to targetID if provided
	if hd and hd.lang and hd.lang.desc then
		desc_wrapped = draw.GetWrappedText(LANG.TryTranslation("tttc_class_" .. hd.name .. "_desc"), 400, "TargetID_Description")

		for i = 1, #desc_wrapped do
			tData:AddDescriptionLine(desc_wrapped[i])
		end
	end
end)

hook.Add("Initialize", "ttt2_classdrop_init_lang", function()
	LANG.AddToLanguage("English", "ttt_class_title", "Class: {class}")
	LANG.AddToLanguage("Deutsch", "ttt_class_title", "Klasse: {class}")

	LANG.AddToLanguage("English", "ttt_pickup_class", "Press [{usekey}] to pickup class")
	LANG.AddToLanguage("Deutsch", "ttt_pickup_class", "Drücke [{usekey}] um Klasse aufzuheben")

	LANG.AddToLanguage("English", "ttt_drop_class_help", "{primaryfire} drops the class")
	LANG.AddToLanguage("Deutsch", "ttt_drop_class_help", "{primaryfire} um die Klasse wegzuwerfen")
end)
