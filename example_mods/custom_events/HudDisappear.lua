function onEvent(name,value1,value2)
	if name == 'HudDisappear' then
		if value2 == null then
			value2 = 1
		end
		if value1 == 'True' then
		        doTweenAlpha('hudalpha', 'camHUD', 0, value2, 'linear');
		end
		if value1 == 'False' then
		        doTweenAlpha('hudalpha2', 'camHUD', 1, value2, 'linear');
		end
	end
end