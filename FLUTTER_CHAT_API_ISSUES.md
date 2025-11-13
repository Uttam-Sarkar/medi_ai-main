# Flutter Chat API Issues & Solutions

## 🚨 Critical Issue Found

The Flutter chat implementation is **incomplete** compared to the React version and **missing required API parameters**.

---

## ❌ Current Flutter Implementation (INCOMPLETE)

### File: `lib/app/data/remote/repository/chat/chat_repository.dart`

```dart
Future<ChatResponse> sendChatMessage(String message, String threadId) async {
  var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
      .post(
        ApiEndPoints.sendMessage,
        {
          "msg": message,
          "lang": selectedLanguage.$,
          "role": userRole.$,
          "thread_id": threadId,
        },
        // ...
      );
}
```

### Problems:
1. ❌ Missing `use_claude` parameter (required by backend)
2. ❌ Missing `userContext` object (required by backend)
3. ❌ Not sending patient medical history
4. ❌ Not sending patient demographics (age, gender)
5. ❌ Not sending allergies, medications, conditions

---

## ✅ What the Backend Expects (From API Documentation)

```json
{
  "msg": "Patient message here",
  "lang": "en",
  "role": "patient",
  "use_claude": false,
  "userContext": {
    "medicalHistory": ["diabetes", "hypertension"],
    "medications": ["metformin", "lisinopril"],
    "allergies": ["penicillin"],
    "age": 45,
    "gender": "male"
  },
  "thread_id": "thread_abc123"  // Optional, for continuity
}
```

---

## 📊 Comparison: React vs Flutter

| Feature | React (Complete) | Flutter (Incomplete) | Status |
|---------|------------------|----------------------|--------|
| `msg` | ✅ Yes | ✅ Yes | OK |
| `lang` | ✅ Yes | ✅ Yes | OK |
| `role` | ✅ Yes | ✅ Yes | OK |
| `thread_id` | ✅ Yes | ✅ Yes | OK |
| `use_claude` | ✅ Yes | ❌ **MISSING** | **BROKEN** |
| `userContext` | ✅ Yes | ❌ **MISSING** | **BROKEN** |
| Medical History | ✅ Sent | ❌ Not sent | **BROKEN** |
| Patient Demographics | ✅ Sent | ❌ Not sent | **BROKEN** |

---

## 🔧 How to Fix

### Step 1: Update ChatRepository

**File:** `lib/app/data/remote/repository/chat/chat_repository.dart`

Change from:
```dart
{
  "msg": message,
  "lang": selectedLanguage.$,
  "role": userRole.$,
  "thread_id": threadId,
}
```

To:
```dart
{
  "msg": message,
  "lang": selectedLanguage.$,
  "role": userRole.$,
  "use_claude": false,  // ← ADD THIS
  "userContext": {      // ← ADD THIS
    "medicalHistory": _getMedicalHistory(),
    "medications": _getMedications(),
    "allergies": _getAllergies(),
    "age": _getAge(),
    "gender": _getGender(),
  },
  "thread_id": threadId.isEmpty ? null : threadId,
}
```

### Step 2: Create Helper Methods

Add these methods to extract user data from SharedValueHelper or user object:

```dart
List<String> _getMedicalHistory() {
  // Extract from user data
  // Example: user.details.medicalHistory.sicknessHistory
  return [];
}

List<String> _getMedications() {
  // Extract from user data
  // Example: user.details.medicalHistory.medicationTypes
  return [];
}

List<String> _getAllergies() {
  // Extract from user data
  // Example: user.details.medicalHistory.allergy
  return [];
}

int _getAge() {
  // Extract from user data
  // Example: user.details.personalDetails.age
  return 0;
}

String _getGender() {
  // Extract from user data
  // Example: user.details.personalDetails.gender
  return "unknown";
}
```

### Step 3: Update API Endpoint

Check `lib/app/network_service/api_end_points.dart`:

```dart
// Make sure this points to the correct endpoint
static const String sendMessage = 'chat/assistant';
```

---

## 🎯 React Implementation Reference

### From React Code (PChatBoxHero.tsx):

The React app builds a comprehensive patient profile:

```javascript
const authorname = `patient name: ${user?.details?.personalDetails?.firstName}`;
const patientGender = `patient gender: ${user?.details?.personalDetails?.gender}`;
const patientWeight = `patient weight: ${user?.details?.personalDetails?.weight}`;
const patientAge = `patient age: ${user?.details?.personalDetails?.age}`;
const patientBloodGroup = `patient Blood Group: ${user?.details?.personalDetails?.bloodType}`;
const patientLifeStyle = `patient life style factors...`;
const medicalHistory = `medical history, medical condition...`;
const vaccineHistory = `vaccine history...`;

// Then sends all this to the API
await post("/chat/assistant", {
  thread_id: threadId,
  msg: /* patient details + message */,
  lang: user?.details?.personalDetails?.language || "en",
  role: user?.role,
  // NOTE: React doesn't send use_claude or userContext either!
  // This might be why React also had issues
});
```

---

## 🔍 Additional Findings

### React Code Also Has Issues!

Looking at the React implementation, it:
1. ❌ Also doesn't send `use_claude`
2. ❌ Also doesn't send `userContext` object
3. ✅ But it does include patient details in the `msg` string itself

### This explains why you got Internal Server Error!

Both React and Flutter implementations are missing required parameters!

---

## ✅ Correct Implementation (What Both Should Do)

```dart
// Flutter
Future<ChatResponse> sendChatMessage(
  String message,
  String threadId,
  UserData user,  // Pass user object
) async {
  // Build userContext from user data
  final userContext = {
    "medicalHistory": user.details?.medicalHistory?.sicknessHistory ?? [],
    "medications": user.details?.medicalHistory?.medicationTypes ?? [],
    "allergies": [user.details?.medicalHistory?.allergy ?? ""],
    "age": user.details?.personalDetails?.age ?? 0,
    "gender": user.details?.personalDetails?.gender ?? "unknown",
  };

  var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
      .post(
        ApiEndPoints.sendMessage,
        {
          "msg": message,
          "lang": selectedLanguage.$ ?? "en",
          "role": userRole.$,
          "use_claude": false,  // or make this configurable
          "userContext": userContext,
          "thread_id": threadId.isEmpty ? null : threadId,
        },
        sendChatMessage,
        isHeaderRequired: true,
        isLoaderRequired: false,
      );
  return /* ... */;
}
```

---

## 🚀 Action Items

### Priority 1: Fix API Parameters (CRITICAL)
- [ ] Add `use_claude` parameter
- [ ] Add `userContext` object
- [ ] Extract patient medical data from user object

### Priority 2: Test with Postman (VERIFY)
- [ ] Use updated Postman collection
- [ ] Test with complete parameters
- [ ] Verify AI response quality

### Priority 3: Update Flutter Implementation
- [ ] Modify `chat_repository.dart`
- [ ] Update `chatbox_controller.dart` to pass user data
- [ ] Test in Flutter app

---

## 📝 Testing Checklist

After fixing:

1. ✅ Open Postman
2. ✅ Test "Chat with AI Assistant" with correct parameters
3. ✅ Verify no Internal Server Error
4. ✅ Check AI response is personalized with medical history
5. ✅ Implement same structure in Flutter
6. ✅ Test Flutter chat functionality

---

## 💡 Why This Matters

Without `userContext`:
- ❌ AI doesn't know patient's medical history
- ❌ AI can't provide personalized advice
- ❌ AI doesn't consider allergies (DANGEROUS!)
- ❌ AI doesn't consider current medications (DANGEROUS!)
- ❌ Backend might reject request as incomplete

With `userContext`:
- ✅ AI gives personalized medical advice
- ✅ AI considers patient's conditions
- ✅ AI warns about drug interactions
- ✅ AI provides age/gender-appropriate guidance
- ✅ Backend processes request correctly

---

## 🎯 Next Steps

1. **Fix the Postman request first** - Test the API works with correct parameters
2. **Then update Flutter code** - Once API works, implement in Flutter
3. **Test thoroughly** - Verify AI responses are better with context

The React code also needs fixing - both frontends are incomplete!
