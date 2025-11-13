# 🩹 Chat API Fix - What Was Wrong

## The Problem

You were getting **Internal Server Error** when testing the Chat API. Here's why:

---

## ❌ What You Were Sending (WRONG)

```json
POST https://mediai.tech/api/chat/assistant

{
  "message": "I have a headache and fever. What should I do?",
  "conversationHistory": [],
  "useOpenAI": true
}
```

### Why This Failed:
- ❌ Backend expects `msg`, not `message`
- ❌ Backend expects `use_claude`, not `useOpenAI`
- ❌ Missing required fields: `lang`, `role`, `userContext`
- ❌ `conversationHistory` is not used (backend uses `thread_id` for continuity)

**Backend response:**
```
500 Internal Server Error
```

---

## ✅ What You Should Send (CORRECT)

```json
POST https://mediai.tech/api/chat/assistant
Authorization: Bearer YOUR_TOKEN_HERE

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

### Why This Works:
- ✅ Correct parameter name: `msg`
- ✅ Correct AI selection: `use_claude` (false = OpenAI, true = Claude)
- ✅ All required fields included
- ✅ `userContext` provides medical background for better AI responses

**Backend response:**
```json
{
  "success": true,
  "data": {
    "thread_id": "thread_abc123",
    "message": "Based on your symptoms of headache and fever...",
    "suggestions": ["Rest", "Hydration", "Consult doctor if persists"],
    "urgencyLevel": "medium"
  }
}
```

---

## 🔄 For Continuing a Conversation

If you want to continue a conversation, add the `thread_id` from the previous response:

```json
{
  "thread_id": "thread_abc123",  // ← Add this for continuity
  "msg": "The headache is getting worse",
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

The AI will remember the previous conversation!

---

## 📊 Parameter Reference

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `msg` | string | ✅ Yes | User's message/question | "I have a headache" |
| `lang` | string | ✅ Yes | Response language code | "en", "es", "fr" |
| `role` | string | ✅ Yes | User role for context | "patient", "doctor" |
| `use_claude` | boolean | ✅ Yes | false = OpenAI, true = Claude | false |
| `userContext` | object | ✅ Yes | Medical background | See below |
| `thread_id` | string | ⚠️ Optional | For conversation continuity | "thread_abc123" |

### userContext Object:
```json
{
  "medicalHistory": ["diabetes", "hypertension"],  // Array of conditions
  "medications": ["metformin", "lisinopril"],      // Current medications
  "allergies": ["penicillin"],                     // Known allergies
  "age": 45,                                       // Patient age
  "gender": "male"                                 // Patient gender
}
```

---

## 🧪 Test It Now in Postman

### Step 1: Open Updated Collection
Import the file: `MediAI_Postman_Collection.json`

### Step 2: Make Sure You're Logged In
Run **Authentication → Login User** first to get your token

### Step 3: Test Chat
Open **AI Chat → Chat with AI Assistant** and click **Send**

### Expected Result:
```json
{
  "success": true,
  "data": {
    "thread_id": "thread_...",
    "message": "AI response here...",
    "suggestions": [...],
    "urgencyLevel": "low|medium|high",
    "disclaimers": [...]
  }
}
```

---

## 🎯 Quick Comparison

| Feature | Old (Wrong) | New (Correct) |
|---------|-------------|---------------|
| Message parameter | `message` | `msg` |
| AI selection | `useOpenAI: true` | `use_claude: false` |
| Language | ❌ Missing | `lang: "en"` |
| Role | ❌ Missing | `role: "patient"` |
| Medical context | ❌ Missing | `userContext: {...}` |
| Conversation continuity | `conversationHistory` | `thread_id` |

---

## 💡 Pro Tips

### Tip 1: Save the thread_id
After the first message, save the `thread_id` from the response. Use it in subsequent requests for conversation continuity.

### Tip 2: Update userContext
Provide accurate medical history for better AI responses. Empty arrays are fine if no history exists.

### Tip 3: Choose the Right AI
- **OpenAI (GPT-4)**: `use_claude: false` - Better for general medical advice
- **Claude**: `use_claude: true` - Better for detailed analysis

### Tip 4: Use Appropriate Language
Set `lang` to the user's preferred language code:
- English: `"en"`
- Spanish: `"es"`
- French: `"fr"`
- Arabic: `"ar"`
- German: `"de"`

---

## ✅ You're All Set!

The Postman collection has been updated with the correct parameters. The Chat API should work perfectly now! 🚀

If you still get errors, check:
1. ✅ Token is valid (re-login if needed)
2. ✅ All required fields are present
3. ✅ Backend server is running
4. ✅ Using correct endpoint: `https://mediai.tech/api/chat/assistant`
