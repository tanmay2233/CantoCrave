// admin.js

const admin = require('firebase-admin');
const serviceAccount = require('./service_key.json'); // Replace with your own service account key

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://cantocrave-9532a.firebaseio.com' // Replace with your project's Firebase URL
},

async function setAdminCustomClaim(uid) {
  try {
    await admin.auth().setCustomUserClaims(uid, { admin: true });
    console.log(`Admin claim set for user ${uid}`);
  } catch (error) {
    console.error(`Error setting admin claim: ${error}`);
  }
},

module.exports = {
  setAdminCustomClaim
})