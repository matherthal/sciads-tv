local text = 'Valor default'

function handler(evt)
	if evt.class ~= 'ncl' then return end
	
	if evt.type == 'attribution' and evt.name == 'text' then
		text = evt.value
		evt.action = 'stop'
		event.post(evt)
		return
	end
	
	if evt.type == 'presentation' and evt.label == 'paint' then
		local dx, dy = canvas:attrSize()
		canvas:attrFont('vera', 3*dy/4)
		canvas:attrColor('white')
		canvas:drawText(0, 0, text)
		canvas:flush()
	end
end
event.register(handler)