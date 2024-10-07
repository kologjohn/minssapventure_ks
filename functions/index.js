const functions = require('firebase-functions');
const axios = require('axios');
const cors = require('cors')({ origin: true });
const admin=require('firebase-admin');
admin.initializeApp();
//exports.paystack=functions.https.onCall(async(datam,context)=>{
//  try{
// if(!context.auth)
// {
//   throw new functions.https.HttpsError('unauthenticated','Not authenticated')
// }
//  const tid=datam.tid;
//   const email=context.auth.token.email;
//
//   //const email="info@gmmail.com";
//   const amount=datam.amount;
//   let intValue = Math.floor(amount)
//   console.log("at: "+intValue);
//   const authToken="sk_live_95b93c88db79714e361d1fc75a4b6e3a818fbd5f";
//   const postdata={
//     "amount": intValue,
//     "email": email,
//     "reference": tid,
//     "currency": "GHS",
//     "paymentChannel": [
//       "mobile_money",
//     ]
//   };
//   const config= {
//     headers:
//     {
//       'Authorization': `Bearer ${authToken}`, 'Content-Type': 'application/json'  // Adjust content type based on your API requirements
//     }
//   };
//   const sendapi=await axios.post('https://api.paystack.co/transaction/initialize',postdata,config)
//   console.log(sendapi.data);
//   return sendapi.data;
//
//  }catch(e){
//console.log(e)
//return e;
//  }
//
//});
exports.paystack = functions.https.onCall(async (data,context) => {
  try {
    // Optional: Check if the user is authenticated
    // if (!context.auth) {
    //   throw new functions.https.HttpsError('unauthenticated', 'User is not authenticated');
    // }
    console.log("Received data:", data);
        // Access the received data (amount and tid)
       // const amount = datam.amount; // '100'
       // const tid = datam.tid;       // '1727371217083'

    const tid = data.tid; // Retrieve the transaction ID
    const email = "eee@ff.co"; // Use hardcoded email or from context if auth is used
    const amount = data.amount; // Amount from the data sent by the client
    let intValue = Math.floor(amount); // Round down the amount to an integer value

    console.log("Transaction ID: " + data);

    const authToken = "sk_live_bf9a34450f154968da0f3c3963c7bbbb3838a7a9"; // Paystack API secret key

    // Step 1: Retrieve ghshipping and ghtotal from the Firestore 'checkout' collection using the tid
    const checkoutDoc = await admin.firestore().collection('checkout').doc(tid).get();

    if (!checkoutDoc.exists) {
      throw new functions.https.HttpsError('not-found', 'Transaction not found');
    }

    const { ghshipping, ghtotal } = checkoutDoc.data();
    console.log(`Shipping: ${ghshipping}, Total: ${ghtotal}`);

    // Calculate the total amount to be charged in GHS
    const totalAmount = (parseFloat(ghshipping) + parseFloat(ghtotal)) * 100; // Convert to kobo (GHS * 100)
    const roundedAmount = Math.floor(totalAmount); // Round down to integer

    // Step 2: Prepare the post data for Paystack API
    const postdata = {
      "amount": roundedAmount, // Amount in kobo
      "email": email, // Customer's email
      "reference": tid, // Unique reference for the transaction
      "currency": "GHS", // Currency
      "paymentChannel": ["mobile_money"] // Mobile money payment channel
    };

    // Step 3: Set up the request headers for Paystack API call
    const config = {
      headers: {
        'Authorization': `Bearer ${authToken}`, // Use Paystack secret key
        'Content-Type': 'application/json'
      }
    };

    // Step 4: Make a server-side request to Paystack API to initialize the transaction
    const sendapi = await axios.post('https://api.paystack.co/transaction/initialize', postdata, config);

   // console.log(sendapi.data); // Log the response from Paystack

    // Return the response to the client, along with additional data
    return {
      ...sendapi.data,
      ghshipping,
      ghtotal
    };

  } catch (e) {
    console.error("Error initializing Paystack transaction:", e);
    throw new functions.https.HttpsError('internal', e.message || 'Something went wrong');
  }
});
exports.currency=functions.https.onCall(async(datam,context)=>{
  try{
//  if(!context.auth)
//  {
//    throw new functions.https.HttpsError('unauthenticated','Not authenticated')
//  }
   const sendapi=await axios.get('https://open.er-api.com/v6/latest/USD')
   console.log(sendapi.data);
   return sendapi.data.rates.GHS;
  }catch(e){
console.log(e)
return e;
  }

});

exports.paystackcall = functions.https.onRequest((req, res) => {
  const responsedata = req.body;
  const status = responsedata.event;
  const reference = responsedata.data.reference;
  const amount = responsedata.data.amount;
  const channel = responsedata.data.channel;
 // res.send(reference);
  var codeupdate={"code":req.body};
  var sendmoneyupdate={"status":true};
  admin.firestore().collection("userstest").doc(reference).set(codeupdate);
  admin.firestore().collection("checkout").doc(reference).update(sendmoneyupdate);
  //var records= admin.firestore().collection("sendmoney").doc(clientid).get();
   res.status(200).send('Success'+reference);
});


exports.chat = functions.https.onCall(async (data, context) => {
  // Ensure the request has the necessary authentication if required
  // if (!context.auth) {
  //   throw new functions.https.HttpsError('unauthenticated', 'Request had no authentication.');
  // }

  const text=data.text;
  const requestData = JSON.stringify({
    "contents": [
      {
        "parts": [
          {
            "text": data.text
          }
        ]
      }
    ]
  });

  const config = {
    method: 'post',
    maxBodyLength: Infinity,
    url: 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAsjYTLt34TtJN80f4cWmB_1H0eLpB5P90',
    headers: {
      'Content-Type': 'application/json'
    },
    data: requestData
  };

  try {
    const response = await axios.request(config);
    return response.data;
  } catch (error) {
    console.error(error);
    throw new functions.https.HttpsError('internal', 'Unable to generate content', error);
  }
});
