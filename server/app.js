const cafeterias = [
    {
        "id": "1",
        "title": "Limón y Chia",
        "rating": 4.5,
        "image": "https://placehold.co/600x400.png",
        "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "schedule": "9:00 - 18:00",
        "lat": 20.606931,
        "lng": -103.416727,
        "foods":[
            {
                "title": "Chilaquiles",
                "price": 50.01,
                "rating": 4.5
            },
            {
                "title": "Molletes",
                "price": 30.01,
                "rating": 4.01
            },
        ]
    },
    {
        "id": "2",
        "title": "Guich",
        "rating": 4.01,
        "image": "https://placehold.co/600x400.png",
        "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "schedule": "9:00 - 18:00",
        "lat": 20.606931,
        "lng": -103.416727,
        "foods":[
            {
                "title": "Ensalada",
                "price": 100.01,
                "rating": 4.5
            },
            {
                "title": "Wrap",
                "price": 70.01,
                "rating": 4.01
            },
        ]
    }
]
const PORT = 3000
const express = require('express')
const app = express()
const routes = express.Router()
routes.get('/cafeterias', async(req,res) =>{
    res.send(cafeterias)
})
app.use('/', routes)
app.listen(PORT, () => console.log(`Listening on port ${PORT}`))