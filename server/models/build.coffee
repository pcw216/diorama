mongoose = require('mongoose')

buildSchema = mongoose.Schema({
    id: Number
})
module.exports = mongoose.model('User', userSchema)
