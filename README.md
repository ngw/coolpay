# Coolpay

```
# use your own credentials
ngw@bluemonday ~/coolpay: bin/coolpay auth username apikey > .token

# fetch or create a recipient
ngw@bluemonday ~/coolpay: bin/coolpay recipient "Regina Phalange"
Regina Phalange:5a6d2cfb-8005-4285-9b04-c1ac25ff86e2 is ready to receive money

# pay it by name
ngw@bluemonday ~/coolpay: bin/coolpay pay "Regina Phalange" USD 20
Your payment of 20 USD to Regina Phalange is processing

# list all payments
ngw@bluemonday ~/coolpay: bin/coolpay list
Payment f53c129b-f87c-44e4-94fd-147a3c4d769d of 20 USD to fe4f9956-d210-4ae5-9255-96707938e006 has status paid
Payment 019afc26-4a50-44ab-bb57-b9f9981ea7de of 20 USD to 5a6d2cfb-8005-4285-9b04-c1ac25ff86e2 has status failed
```

### Improvements

`CoolPay::Payment#list` doesn't return `CoolPay::Payment` objects, which is rather ugly.
Early in the project I've decided to avoid wrapping the whole API to concentrate on building a client,
because apparently that was the point of the exercise. This brought me to objects that interact with
the API on initialisation, as their purpose is to interact with the API to create a client instead of
wrapping the API.
If I had to refactor this I'd probably let `CoolPay::Payment` fetch its own `CoolPay::Recipient` only
in absence of an ID, which would indicate the payment has already been created.

`CoolApi::CLI` is almost untested.
I've tried to keep the logic inside the classes, testing Thor commands is rather ugly and always ends
up in testing 80% the Thor library and 20% the code underneath.
This choice was mostly done because it's Sunday and I'm lazy, I'd test the CLI in a production environment.
This is a test and I decided to search for Dilbert comics instead. KTNXBYE.


![Alt desc](https://github.com/nofeed/coolpay/blob/master/assets/dilbert.gif)
