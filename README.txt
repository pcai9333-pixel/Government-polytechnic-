UPI PAYMENT RECORD SYSTEM

What this adds:
- Existing student fee/payment page remains the main page.
- After a student taps "Yes, I Paid" and enters the UPI reference number, the record is sent to Supabase.
- admin.html lets the authorized admin log in and view all submitted records.
- The admin can export the records to one PDF.
- The UPI app does NOT automatically reveal private payer/bank information to the webpage. The student submits the transaction/reference number and student details.

Setup:
1. Create a Supabase project.
2. Run supabase.sql in Supabase SQL Editor.
3. Create an admin user in Authentication > Users.
4. Replace ADMIN-USER-UUID in supabase.sql with the admin user's UUID and run the two policy statements again if needed.
5. Put your Supabase Project URL and anon key into BOTH index.html and admin.html.
6. Verify your official college UPI ID in index.html.
7. Host index.html and admin.html on a static host (Netlify, Vercel, GitHub Pages, etc.).
8. Open admin.html only for the authorized admin.

Important:
- Do not put a Supabase service-role key in HTML.
- Do not collect card PIN, UPI PIN, OTP, or full bank-account credentials.
- The current original page uses localStorage, which is only on the individual device; this package adds central Supabase storage.
