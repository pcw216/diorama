mongoose = require('mongoose')

buildSchema = mongoose.Schema({
    id: Number,
    url: String,
    name: String,
    description: String,
    status: String    
})
module.exports = mongoose.model('Build', buildSchema)
