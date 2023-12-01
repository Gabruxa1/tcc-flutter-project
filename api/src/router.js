const express = require('express')
const funcionariosController = require ('./controllers/funcionariosControllers')
const router = express.Router();

router.get('/funcionarios', funcionariosController.getAll);
router.get('/funcionarios/ativos', funcionariosController.getActives);


module.exports = router 