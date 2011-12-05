require 'tcp'

function handler (evt)
	if evt.class  ~= 'ncl'         then return end
	if evt.type   ~= 'attribution' then return end
	if evt.action ~= 'start'       then return end
	if evt.name   ~= 'envia'      then return end

	event.post {
		class  = 'ncl',
		type   = 'attribution',
		name   = 'envia',
		action = 'stop',
	}

	tcp.execute(
		function ()
			--tcp.connect('189.25.99.61', 8080)
			tcp.connect('192.168.1.3', 8080)
			tcp.send(evt.value..'\n')
			print("Mensagem enviada!")
			local recebe = tcp.receive()
			if recebe ~= '\n' then
				print("Mensagem recebida: "..recebe)
				recebe = string.sub(recebe,1,string.len(recebe) - 1)
			else
				return
			end
			local evt = {
				class = 'ncl',
				type  = 'attribution',
				name  = 'recebe',
				value = recebe,
			}
			evt.action = 'start'; event.post(evt)
			evt.action = 'stop' ; event.post(evt)
			tcp.disconnect()
		end
	)
end
event.register(handler)
