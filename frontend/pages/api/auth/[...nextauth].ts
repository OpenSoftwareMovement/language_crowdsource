import { NextApiRequest, NextApiResponse } from "next";
import NextAuth from "next-auth";
import GoogleProvider from "next-auth/providers/google";
import admin from 'firebase-admin'
import IAccount from "types/account";
import iToken from "types/token";
import IUser from "types/user";
import ISession from "types/session";

const serviceAccount = require("../../../service-account.json")

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: process.env.FIRESTORE_DATABASE_URL,
  });
}


const options = {
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
  ],
  secret: process.env.JWT_SECRET, //PUT YOUR OWN SECRET (command: openssl rand -base64 32)
  database: process.env.NEXT_PUBLIC_DATABASE_URL,
  session: {
    strategy: "jwt",
  },
  debug: true,
  callbacks: {
    async session({ session, token, user }) {
      session.jwt = token.jwt;
      session.id = token.id;

      return session;
    },
    async jwt({ token, user, account, profile, isNewUser }) {
      const isSignIn = user ? true : false;

      if (isSignIn) {
        const apiUrl = `${process.env.NEXT_PUBLIC_API_URL}/auth/${account.provider}/callback?access_token=${account?.access_token}`;

        try {
          const response = await fetch(apiUrl);
          const data = await response.json();

          token.jwt = data.jwt;
          token.id = data.user.id;
          
          const firebaseUid = data.user.id
          try {
            await admin.firestore().collection("users").doc(firebaseUid).set({...user, provider: account?.provider});
          } catch (error) {
            console.error('Error creating Firestore document:', error);
          }
        } catch (error) {
          console.error("Fetch error:", error);
        }
      }

      return token;
    },
  },
};

const Auth = (req: NextApiRequest, res: NextApiResponse) =>
  NextAuth(req, res, options);

export default Auth;
