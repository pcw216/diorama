# diorama

resemble('./client/public/images/test_A.jpg').compareTo('./client/public/images/test_A.gen.jpg').ignoreColors().onComplete(function(data){ console.log(data.getImageDataUrl())})


resemble = require('resemblejs').resemble
testA = require('fs').readFileSync('./client/public/images/test_A.jpg')
testAgen = require('fs').readFileSync('./client/public/images/test_A.gen.jpg'
resemble(testA).compareTo(testAgen).ignoreColors().onComplete (data)-> console.log(arguments)
