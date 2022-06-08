const express = require('express')
const app = express();
const morgan = require('morgan');
const path = require('path')
const exphbs = require('express-handlebars')

app.set('port', process.env.PORT || 5000)
app.set('views', path.join(__dirname, 'views'))
app.engine('hbs', exphbs.engine({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs'
}));

app.set('view engine', '.hbs')

//Middlewares
app.use(morgan('dev'));

app.listen(app.get('port'), () => {
    console.log('Server listening on port', app.get('port'));
})