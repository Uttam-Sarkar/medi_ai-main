# API Corrections for Postman Collection

## 🔧 Issues Found & Fixed

Based on the full API documentation review, here are the corrections made to the Postman collection:

---

## 1. ✅ AI Chat API - FIXED

### ❌ **OLD (Incorrect - Caused Internal Server Error)**
```json
{
  "message": "I have a headache and fever",
  "conversationHistory": [],
  "useOpenAI": true
}
```

### ✅ **NEW (Correct)**
```json
{
  "msg": "I have been experiencing headache and fever for 2 days",
  "lang": "en",
  "role": "patient",
  "use_claude": false,
  "userContext": {
    "medicalHistory": [],
    "medications": [],
    "allergies": [],
    "age": 30,
    "gender": "male"
  }
}
```

**Key Changes:**
- `message` → `msg`
- `useOpenAI` → `use_claude` (and inverted logic: false = OpenAI, true = Claude)
- Added required fields: `lang`, `role`, `userContext`
- Removed `conversationHistory` (use `thread_id` for continuity instead)

---

## 2. ✅ Chat Summary API - FIXED

### ❌ **OLD (Incorrect)**
```json
{
  "conversationHistory": [
    {"role": "user", "content": "I have a headache"},
    {"role": "assistant", "content": "I understand..."}
  ]
}
```

### ✅ **NEW (Correct)**
```json
{
  "messages": [
    {
      "role": "user",
      "content": "I have chest pain",
      "timestamp": "2025-11-10T10:30:00.000Z"
    },
    {
      "role": "assistant",
      "content": "Tell me more...",
      "timestamp": "2025-11-10T10:30:15.000Z"
    }
  ],
  "userId": "507f1f77bcf86cd799439011",
  "language": "en"
}
```

**Key Changes:**
- `conversationHistory` → `messages`
- Added `timestamp` to each message
- Added required fields: `userId`, `language`

---

## 3. ⚠️ User Registration - Note on Structure

The API accepts flexible registration with fields automatically organized into `details` object:

```json
{
  "email": "user@example.com",
  "phoneNumber": "+1234567890",  // Email OR phone required
  "password": "securePassword123",
  "type": "patient",  // NOT "role"
  "firstName": "John",
  "lastName": "Doe",
  "gender": "male",
  "dateOfBirth": "1990-01-01",
  // Any additional fields go into details object automatically
}
```

**Response includes:**
- Auto-generated `mediid` (e.g., "01123456p")
- User `role` (same as type)
- All extra fields in `details` object

---

## 4. ⚠️ User Login - Token Location

Token is returned at the **root level** of response, NOT inside data:

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "_id": "...",
    "email": "...",
    "role": "patient"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."  // HERE!
}
```

---

## 5. ✅ All Other APIs - Verified Correct

The following endpoints in the collection are already correct:
- User Profile (`GET /users/profile`)
- Update Details (`POST /users/update-details`)
- Get Hospitals (`POST /users/get-hospitals`)
- Patient Management (Add/Remove/Handle Invitation)
- Form Management (Create/Temp Forms)
- File Upload (Cloudinary)
- News Management
- Translation

---

## 📝 Testing Recommendations

### Test in This Order:

1. **Register** → Get your `mediid` and `userId`
2. **Login** → Get authentication `token` (auto-saved in collection)
3. **Get Profile** → Verify authentication works
4. **Chat with AI** → Test corrected chat endpoint
5. **Chat Summary** → Test corrected summary endpoint
6. **Other Endpoints** → Test remaining features

---

## 🐛 Common Issues & Solutions

### Issue: "Internal Server Error" on Chat API
**Cause**: Using old parameter names (`message`, `useOpenAI`)
**Solution**: Use corrected parameters (`msg`, `use_claude`, `lang`, `role`, `userContext`)

### Issue: "Missing required fields" on Registration
**Cause**: Using `role` instead of `type`
**Solution**: Use `type` field with values: `patient`, `hospital`, `doctor`, etc.

### Issue: Token not auto-saving after login
**Cause**: Postman test script looking in wrong location
**Solution**: Token is at root level: `response.token` (not `response.data.token`)

### Issue: Chat conversation not continuing
**Cause**: Not passing `thread_id`
**Solution**: Save `thread_id` from first chat response, pass it in subsequent requests for conversation continuity

---

## 🔑 Key API Parameter Differences

| Feature | Wrong Parameter | Correct Parameter |
|---------|----------------|-------------------|
| Chat | `message` | `msg` |
| Chat | `useOpenAI` | `use_claude` (inverted) |
| Chat Summary | `conversationHistory` | `messages` (with timestamps) |
| Registration | `role` | `type` |
| User Updates | Direct fields | `email` + `updatedFields` object |
| Patient Add | Direct assignment | Connection request system |

---

## ✅ Collection Updated

The file `MediAI_Postman_Collection.json` has been updated with all corrections.

**To use the corrected collection:**
1. Import `MediAI_Postman_Collection.json` into Postman
2. Create environment with `baseUrl = https://mediai.tech/api`
3. Start testing with Authentication → Login

All endpoints should now work without Internal Server Errors!
