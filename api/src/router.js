const express = require('express');
const funcionariosController = require('./controllers/funcionariosControllers');
const employeeMiddleware = require('./middlewares/employeeMiddleware');
const router = express.Router();

router.get('/funcionarios', funcionariosController.getAll);
router.get('/funcionarios/ativos', funcionariosController.getActives);
router.post('/funcionarios', employeeMiddleware.validateBody, employeeMiddleware.checkDuplicateEmail, employeeMiddleware.checkDuplicateCPF, funcionariosController.createEmployee);
router.delete('/funcionarios/:id', funcionariosController.deleteEmployee);
router.put('/funcionarios/:id', funcionariosController.updateEmployee);

module.exports = router;
