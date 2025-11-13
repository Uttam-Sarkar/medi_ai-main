# Postman API Testing Guide for MediAI

This guide will help you test the MediAI backend APIs using Postman step-by-step.

## Table of Contents
1. [Getting Started](#getting-started)
2. [Environment Setup](#environment-setup)
3. [Authentication Flow](#authentication-flow)
4. [Testing Core APIs](#testing-core-apis)
5. [Common Issues & Solutions](#common-issues--solutions)

---

## Getting Started

### Prerequisites
1. **Install Postman**: Download from [postman.com](https://www.postman.com/downloads/)
2. **Backend Server Running**: Make sure your Node.js backend is running
3. **Know Your Base URL**: Check your `.env` file for the API base URL

### Finding Your API Base URL

Based on your `.env` file:
```
HTTPS=true
DOMAIN_PATH=mediai.tech
API_END_PATH=api/users/
```

This means your **Base URL** is: `https://mediai.tech/api/users/`

**Note**: Some endpoints use different paths:
- User APIs: `https://mediai.tech/api/users/`
- Form APIs: `https://mediai.tech/api/form/`
- Chat APIs: `https://mediai.tech/api/chat/`
- Invoice APIs: `https://mediai.tech/api/invoice/`
- News APIs: `https://mediai.tech/api/news/`

---

## Environment Setup

### Step 1: Create a Postman Environment

1. Open Postman
2. Click "Environments" in the left sidebar
3. Click "Create Environment" (+ button)
4. Name it "MediAI Local"
5. Add these variables:

| Variable | Initial Value | Current Value |
|----------|--------------|---------------|
| baseUrl | https://mediai.tech/api | https://mediai.tech/api |
| token | | |
| userId | | |
| mediid | | |

6. Click "Save"
7. Select "MediAI Local" from the environment dropdown (top right)

---

## Authentication Flow

### Test 1: User Registration

**Purpose**: Create a new user account

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/users/register
```

**Note**: The full URL will be `https://mediai.tech/api/users/register`

**Headers:**
```
Content-Type: application/json
```

**Body (JSON - raw):**
```json
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "SecurePass123!",
  "type": "patient",
  "phoneNumber": "+1234567890",
  "age": 30,
  "gender": "male",
  "address": "123 Main St, City",
  "location": {
    "type": "Point",
    "coordinates": [-73.935242, 40.730610]
  }
}
```

**Expected Response (200 OK):**
```json
{
  "message": "User registered successfully",
  "user": {
    "_id": "507f1f77bcf86cd799439011",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "mediid": "MED123456",
    "type": "patient"
  }
}
```

**After Success:**
- Copy the `_id` value → Set as `userId` in environment
- Copy the `mediid` value → Set as `mediid` in environment

---

### Test 2: User Login

**Purpose**: Authenticate and get access token

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/users/login
```

**Headers:**
```
Content-Type: application/json
```

**Body (JSON - raw):**
```json
{
  "email": "john.doe@example.com",
  "password": "SecurePass123!"
}
```

**Expected Response (200 OK):**
```json
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "_id": "507f1f77bcf86cd799439011",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "type": "patient",
    "mediid": "MED123456"
  }
}
```

**After Success:**
- Copy the `token` value → Set as `token` in environment
- **IMPORTANT**: You'll use this token for all authenticated requests

---

## Testing Core APIs

### Test 3: Get User Profile (Authenticated Request)

**Purpose**: Retrieve logged-in user's profile

**Request Setup:**
```
Method: GET
URL: {{baseUrl}}/users/profile
```

**Headers:**
```
Content-Type: application/json
Authorization: Bearer {{token}}
```

**Expected Response (200 OK):**
```json
{
  "_id": "507f1f77bcf86cd799439011",
  "name": "John Doe",
  "email": "john.doe@example.com",
  "type": "patient",
  "mediid": "MED123456",
  "phoneNumber": "+1234567890"
}
```

---

### Test 4: Update User Details

**Purpose**: Update user information

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/users/update-details
```

**Headers:**
```
Content-Type: application/json
Authorization: Bearer {{token}}
```

**Body (JSON - raw):**
```json
{
  "email": "john.doe@example.com",
  "updatedFields": {
    "name": "John Updated Doe",
    "phoneNumber": "+1987654321"
  }
}
```

**Expected Response (200 OK):**
```json
{
  "message": "User updated successfully",
  "user": {
    "_id": "507f1f77bcf86cd799439011",
    "name": "John Updated Doe",
    "email": "john.doe@example.com",
    "phoneNumber": "+1987654321"
  }
}
```

---

### Test 5: Search Hospitals

**Purpose**: Find nearby hospitals

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/users/get-hospitals
```

**Headers:**
```
Content-Type: application/json
Authorization: Bearer {{token}}
```

**Body (JSON - raw):**
```json
{
  "userId": "{{userId}}",
  "page": 1,
  "searchTerm": "",
  "specialtyRequired": "cardiology"
}
```

**Expected Response (200 OK):**
```json
{
  "hospitals": [
    {
      "_id": "507f1f77bcf86cd799439012",
      "name": "City General Hospital",
      "email": "info@citygeneral.com",
      "type": "hospital",
      "specialties": ["cardiology", "neurology"],
      "distance": 2.5,
      "matchScore": 0.95
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 3,
    "totalResults": 25,
    "hasMore": true
  }
}
```

---

### Test 6: AI Chat with Assistant

**Purpose**: Send a message to AI assistant

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/chat/assistant
```

**Headers:**
```
Content-Type: application/json
Authorization: Bearer {{token}}
```

**Body (JSON - raw):**
```json
{
  "message": "I have a headache and fever",
  "conversationHistory": [],
  "useOpenAI": true
}
```

**Expected Response (200 OK):**
```json
{
  "reply": "Based on your symptoms of headache and fever, you may be experiencing a viral infection. However, I recommend consulting with a healthcare professional for an accurate diagnosis...",
  "model": "gpt-4"
}
```

---

### Test 7: Create a Form (Hospital User)

**Purpose**: Create a medical form

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/form/create
```

**Headers:**
```
Content-Type: application/json
Authorization: Bearer {{token}}
```

**Body (JSON - raw):**
```json
{
  "userId": "{{userId}}",
  "formName": "Patient Intake Form",
  "fields": [
    {
      "label": "Full Name",
      "type": "text",
      "required": true,
      "options": []
    },
    {
      "label": "Date of Birth",
      "type": "date",
      "required": true,
      "options": []
    },
    {
      "label": "Symptoms",
      "type": "select",
      "required": true,
      "options": ["Fever", "Cough", "Headache", "Fatigue"]
    }
  ]
}
```

**Expected Response (201 Created):**
```json
{
  "message": "Form created successfully",
  "form": {
    "_id": "507f1f77bcf86cd799439013",
    "userId": "507f1f77bcf86cd799439011",
    "formName": "Patient Intake Form",
    "fields": [...],
    "createdAt": "2025-11-10T12:00:00.000Z"
  }
}
```

---

### Test 8: File Upload (Cloudinary)

**Purpose**: Upload a medical document or image

**Request Setup:**
```
Method: POST
URL: {{baseUrl}}/invoice/upload
```

**Headers:**
```
Authorization: Bearer {{token}}
(Do NOT set Content-Type - Postman will auto-set it for form-data)
```

**Body (form-data):**
| Key | Type | Value |
|-----|------|-------|
| file | File | [Select a file from your computer] |

**Expected Response (200 OK):**
```json
{
  "url": "https://res.cloudinary.com/your-cloud/image/upload/v1234567890/medical_docs/xyz.pdf"
}
```

---

## Common Issues & Solutions

### Issue 1: "Unauthorized" or "Token expired"
**Solution:**
1. Re-login using Test 2 (User Login)
2. Copy the new token
3. Update the `token` variable in your environment

---

### Issue 2: "Cannot POST /api/users/register"
**Solution:**
1. Check if backend server is running
2. Verify base URL in environment matches your `.env` file
3. Check for typos in the endpoint

---

### Issue 3: "Validation Error" or "Missing required fields"
**Solution:**
1. Check the Body tab in Postman
2. Ensure all required fields from the examples are included
3. Verify JSON syntax is correct (use Postman's "Beautify" button)

---

### Issue 4: CORS Error
**Solution:**
1. This shouldn't happen in Postman (CORS is browser-specific)
2. If you see this, check backend CORS configuration
3. Ensure backend allows `http://localhost:5000`

---

### Issue 5: File Upload Not Working
**Solution:**
1. Make sure you're using `form-data` (NOT `raw` or `JSON`)
2. DO NOT manually set Content-Type header
3. Select the file using the "Select Files" button in Postman

---

## Quick Reference: Common Headers

### For JSON Requests:
```
Content-Type: application/json
Authorization: Bearer {{token}}
```

### For File Uploads:
```
Authorization: Bearer {{token}}
(Let Postman auto-set Content-Type for form-data)
```

---

## Testing Workflow

### Recommended Testing Order:

1. ✅ **Register** → Get userId and mediid
2. ✅ **Login** → Get authentication token
3. ✅ **Get Profile** → Verify authentication works
4. ✅ **Update Details** → Test authenticated POST
5. ✅ **Search Hospitals** → Test complex queries
6. ✅ **AI Chat** → Test external integrations
7. ✅ **Create Form** → Test data creation
8. ✅ **File Upload** → Test multipart/form-data

---

## Pro Tips

### Tip 1: Save Your Requests in a Collection
1. Create a new Collection called "MediAI APIs"
2. Save each test request in the collection
3. You can run the entire collection at once!

### Tip 2: Use Environment Variables
- Instead of `http://localhost:5000/api`, use `{{baseUrl}}`
- Instead of hardcoding token, use `{{token}}`
- This makes switching between dev/staging/prod easy!

### Tip 3: Use Postman Tests Tab
Add this to the "Tests" tab in Login request to auto-save token:
```javascript
if (pm.response.code === 200) {
    const response = pm.response.json();
    pm.environment.set("token", response.token);
    pm.environment.set("userId", response.user._id);
}
```

### Tip 4: Check Response Status
- 200 OK = Success
- 201 Created = Resource created successfully
- 400 Bad Request = Check your request body
- 401 Unauthorized = Token missing or invalid
- 404 Not Found = Wrong endpoint URL
- 500 Internal Server Error = Backend issue

---

## Next Steps

1. **Start with authentication tests** (Register → Login → Get Profile)
2. **Gradually test other endpoints** based on your user role
3. **Save successful requests** in a Postman Collection
4. **Document any API issues** you find
5. **Use this guide** as reference while building Flutter app

---

## Need Help?

If you encounter issues:
1. Check the backend console logs
2. Verify your `.env` file configuration
3. Ensure MongoDB is running
4. Check network connectivity
5. Review this guide's Common Issues section

Happy Testing! 🚀
