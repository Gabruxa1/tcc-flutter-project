const funcionariosModel = require('../../models/funcionariosModel');

const handleBadRequest = (response, message) => {
	return response.status(400).json({ error: message });
};

const checkDuplicateEmail = async (request, response, next) => {
	try {
		const { email } = request.body;
		const isActive = await funcionariosModel.checkDuplicateByEmail(email);

		if (isActive) {
			return handleBadRequest(response, 'Email já utilizado. Não é possível efetuar registros duplicados.');
		}

		next();
	} catch (error) {
		return response.status(500).json({ error: 'Erro ao verificar a duplicidade de email.' });
	}
};


const checkDuplicateCPF = async (request, response, next) => {
	try {
		const { cpf } = request.body;
		const isActive = await funcionariosModel.checkDuplicateByCPF(cpf);

		if (isActive) {
			return handleBadRequest(response, 'CPF já cadastrado. Não é possível efetuar registros duplicados.');
		}

		next();
	} catch (error) {
		return response.status(500).json({ error: 'Erro ao verificar a duplicidade de CPF.' });
	}
};

const validateBody = async (request, response, next) => {
	const { body } = request;
	const { cpf, email } = body;

	const hasEmptyValues = Object.values(body).some(value => value === undefined || value === '');

	if (hasEmptyValues) {
		return handleBadRequest(response, 'O corpo da requisição contém valores vazios ou não definidos.');
	}

	const isValidCPF = /^\d{11}$/.test(cpf);

	if (!isValidCPF) {
		return handleBadRequest(response, 'CPF inválido. Deve conter somente números e ter 11 dígitos.');
	}

	const isValidEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

	if (!isValidEmail) {
		return handleBadRequest(response, 'Email inválido.');
	}

	next();
};

module.exports = {
	validateBody,
	checkDuplicateEmail,
	checkDuplicateCPF
};
