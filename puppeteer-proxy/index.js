const puppeteer = require('puppeteer');
const express = require('express');
const validUrl = require('valid-url');

const app = express();

app.get('/', async (req, res) => {

    const {uri} = req.query;

    if(validUrl.isHttpUri(uri) || validUrl.isHttpsUri(uri)) {

        try {
                const browser = await puppeteer.launch({args: ['--no-sandbox']});
                const page = await browser.newPage();
                await page.goto(`${uri}`);
                let document = await page.evaluate(() => document.documentElement.outerHTML);
                console.log(uri);
                return res.send(document);
        } catch(err) {
                console.log(err);
        }

    } else {
        console.log(uri);
        return res.send('ERROR: A valid URL was not provided.');
    }

});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});

// Handle ^C
process.on('SIGINT', () => {
  console.log('Received SIGINT.');
  process.exit();
});
