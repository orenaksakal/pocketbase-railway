// OTP hook
onRecordRequestOTPRequest((e) => {
    // create a user with the OTP email if it doesn't exist
    if (!e.record) {
        // read the email and any other extra user data you are submitting
        // with the OTP request to create a new user
        let email = e.requestInfo().body["email"]

        let record = new Record(e.collection)
        record.setEmail(email)
        record.setPassword($security.randomString(30))
        e.app.save(record)

        e.record = record
    }

    return e.next()
}, "users")
