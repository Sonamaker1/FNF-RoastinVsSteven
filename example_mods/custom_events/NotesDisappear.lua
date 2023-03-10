function onEvent(name,value1,value2)
	if name == 'NotesDisappear' then
		if value2 == null then
			value2 = 1
		end
		if value1 == 'True' then
		        doTweenAlpha('notesalpha', 'camNOTES', 0, value2, 'linear');
		        doTweenAlpha('notehudalpha', 'camNOTEHUD', 0, value2, 'linear');
		end
		if value1 == 'False' then
		        doTweenAlpha('notesalpha2', 'camNOTES', 1, value2, 'linear');
		        doTweenAlpha('notehudalpha2', 'camNOTEHUD', 1, value2, 'linear');
		end
	end
end