const admin = require("firebase-admin");
const serviceAccount = require("./service_key.json"); // Update with the path to your JSON key file

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://cantocrave-9532a.firebaseio.com", // Replace with your Firebase project's database URL
});

const firestore = admin.firestore();

async function uploadData() {
  const data = require("./Menu.json");
  const collectionName = "Menu_Items";

  try {
    const characters = "abcdefghijklmnopqrstuvwxyz"; // Alphabetic characters

    for (let i = 0; i < data.length; i++) {
      const firstChar = characters[Math.floor(i / 26)]; // First character
      const secondChar = characters[i % 26]; // Second character
      const id = `${firstChar}${secondChar}`; // Combine characters
      const docRef = firestore.collection(collectionName).doc(id);
      await docRef.set(data[i]);
      console.log(`Document added with ID: ${id}`);
    }
  } catch (error) {
    console.error("Error uploading data:", error);
  }
}

uploadData();
