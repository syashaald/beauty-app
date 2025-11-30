# 🔧 CRUD Troubleshooting Guide

## Common Issues & Solutions

---

## ❌ Error: "Product created but not showing"

### Symptoms
- Created product successfully (got notification)
- But product doesn't appear in Home/Admin

### Solutions
1. **Refresh the page**
   ```
   Admin Panel → Pull down to refresh
   Home → Navigate away and back
   ```

2. **Check Supabase connection**
   - Verify internet connection
   - Check if Supabase URL is correct in `main.dart`
   - Check API key is valid

3. **Clear cache**
   ```
   Restart app completely
   Force close and reopen
   ```

4. **Database issue**
   - Check Supabase dashboard
   - Verify `products` table exists
   - Check table has correct columns

### Code to Check
```dart
// In main.dart - verify these are correct:
await Supabase.initialize(
  url: 'https://yubngkhbfumsuvedeyrb.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
);
```

---

## ❌ Error: "Update not saved"

### Symptoms
- Edit product successfully
- But changes don't appear

### Solutions
1. **Check validation**
   - Form shows red underline = validation failed
   - Fix all marked fields
   - Try again

2. **Verify data**
   - Check what you typed
   - Ensure price is number, not text
   - Ensure rating is 0-5

3. **Network issue**
   - Check internet connection
   - Try refreshing and editing again
   - Check app logs for network errors

4. **Browser cache**
   - Clear browser cache
   - Close app completely
   - Reopen and try again

### Debug: Check Supabase Logs
1. Go to Supabase dashboard
2. Check "Logs" section
3. Look for your API calls
4. Check for error messages

---

## ❌ Error: "Delete button not working"

### Symptoms
- Click delete button
- Nothing happens
- Or error message appears

### Solutions
1. **Confirmation dialog not appearing?**
   - Check if dialog opens (might be behind)
   - Confirm the delete action
   - Dialog needs explicit yes/no

2. **Network timeout**
   ```
   Wait a few seconds
   Check internet connection
   Try again
   ```

3. **Product already deleted**
   - Refresh admin panel
   - Product might be deleted already
   - Check other devices/tabs

4. **Permission issue**
   - Check Supabase RLS (Row Level Security)
   - Verify anonKey has delete permission
   - Check database settings

---

## ❌ Error: "Image not showing"

### Symptoms
- Product shows placeholder image
- Not the image you uploaded

### Solutions
1. **Invalid URL**
   - Copy-paste URL in browser
   - Verify it shows image
   - URL must be HTTPS (not HTTP)
   - Try different image hosting:
     - Supabase Storage
     - Imgur
     - Cloudinary
     - Firebase Storage

2. **Broken URL**
   - Check if URL changed
   - Verify image still exists
   - Try image from different source

3. **Network issue**
   - Check internet connection
   - Disable VPN if using
   - Try different network

**Working Image URLs:**
```
✅ https://via.placeholder.com/300
✅ https://images.unsplash.com/...
❌ http://example.com/... (not HTTPS)
❌ file:///path/to/image (local file)
```

---

## ❌ Error: "Admin button not visible"

### Symptoms
- Can't find Admin button on Home page
- Missing the button to access management panel

### Solutions
1. **Scroll to top**
   - Admin button is at very top of Home
   - Scroll up to see it

2. **Try different device**
   - Different screen sizes might arrange UI differently
   - Check if button appears on web/mobile

3. **Rebuild app**
   ```
   flutter clean
   flutter pub get
   flutter run
   ```

### Alternative Access
If you can't find admin button:
1. Go to Categories page
2. Open developer tools
3. Look at page structure
4. Can manually navigate if needed

---

## ❌ Error: "Form validation keeps failing"

### Symptoms
- All fields filled but still shows error
- Can't submit form

### Solutions

**Check each field:**
```
Name:        Not empty? ✓
Brand:       Not empty? ✓
Category:    Not empty? ✓
Price:       Number only? ✓
Rating:      Number 0-5? ✓
Image URL:   URL format? ✓
Short Desc:  Not empty? ✓
Full Desc:   Not empty? ✓
```

**Common mistakes:**
- ❌ Price: "Rp 50000" → use just "50000"
- ❌ Rating: "4.5 out of 5" → use just "4.5"
- ❌ Image: "myimage.jpg" → need full URL
- ❌ Copy-paste errors → leading/trailing spaces

**Fix:**
1. Clear each field
2. Re-type carefully
3. Avoid copy-paste with spaces
4. Use simple, clean text

---

## ❌ Error: "Search not working"

### Symptoms
- Type in search box
- Nothing happens
- Products not filtered

### Solutions
1. **Case sensitive?**
   - Search is case-INSENSITIVE
   - "face", "Face", "FACE" all work

2. **Partial match**
   - Type "fac" to find "Face Care"
   - Works with brand too: "ban" finds "Banana"

3. **Space issue**
   - Remove extra spaces
   - Type carefully
   - Check for leading/trailing spaces

4. **Try clearing**
   ```
   Search box → Select all → Delete
   Wait for full list to appear
   Type again
   ```

**Search Examples:**
```
✅ "Product" → finds all products with "Product" in name
✅ "Br" → finds all brands starting with "Br"
✅ "care" → finds "Face Care", "Body Care", "Hair Care"
❌ "  face  " → might not work (spaces issue)
```

---

## ❌ Error: "App crashes when opening Admin"

### Symptoms
- Click Admin button
- App closes/crashes
- Error message in console

### Solutions
1. **Check console logs**
   ```
   flutter run -v (verbose mode)
   Look for error messages
   ```

2. **Null pointer exception?**
   - Usually means data not loaded
   - Wait for initial load to complete
   - Check internet connection

3. **Memory issue**
   - Too many products?
   - Close other apps
   - Restart phone
   - Clear cache

4. **Build issue**
   ```
   flutter clean
   flutter pub get
   flutter run
   ```

---

## ❌ Error: "Supabase connection failed"

### Symptoms
- Can't see any products
- Always loading
- Network errors

### Solutions
1. **Check internet**
   ```
   Open browser → google.com
   Verify connection working
   ```

2. **Check Supabase status**
   ```
   Visit status.supabase.com
   Check if service is down
   ```

3. **Verify credentials**
   ```dart
   // In main.dart, check:
   - URL is correct
   - anonKey is correct
   - No extra spaces
   ```

4. **Firewall/VPN**
   - Disable VPN temporarily
   - Check if company firewall blocks it
   - Try different network

5. **CORS issue**
   - Usually not issue for Flutter
   - But if error: check Supabase CORS settings

**Test Connection:**
```dart
try {
  final response = await supabase
    .from('products')
    .select()
    .limit(1);
  print('Connected: $response');
} catch (e) {
  print('Error: $e');
}
```

---

## ❌ Error: "Confirmation dialog not showing"

### Symptoms
- Click delete
- Nothing visible
- But app still responds

### Solutions
1. **Dialog might be off-screen**
   - Look for dialog behind elements
   - Take screenshot of entire screen

2. **Rebuild might help**
   ```
   Close app
   flutter clean
   flutter run
   ```

3. **OS-level dialogs**
   - Different on Android vs iOS
   - Layout might be different
   - But functionality should work

---

## ⚡ Performance Issues

### App is slow/laggy

**Solutions:**
1. **Too many products?**
   - Implement pagination
   - Load products in batches
   - Clear old data

2. **Images loading slow?**
   - Use smaller image sizes
   - Optimize image URLs
   - Enable caching (already done)

3. **Reduce database queries**
   - Cache results locally
   - Avoid repeated fetches
   - Use refresh strategically

4. **Device too old?**
   - Run on modern device
   - Flutter very performant, but extreme cases

---

## 🔍 Debug Mode

### Enable verbose logging
```bash
flutter run -v
```

### Check specific errors
```dart
// Add to code temporarily for debugging
print('DEBUG: Creating product...');
try {
  await api.createProduct(...);
  print('DEBUG: Success');
} catch (e) {
  print('DEBUG: Error = $e');
}
```

### Monitor Supabase
1. Supabase Dashboard
2. SQL Editor
3. Run: `SELECT * FROM products;`
4. Verify data is there

---

## 📞 When Still Stuck

### Collect Info
1. What exactly did you do?
2. What error message did you see?
3. Check console logs
4. Try on different device
5. Verify internet connection

### Check These Files
- `lib/services/api_service.dart` - CRUD methods
- `lib/pages/add_edit_product_page.dart` - Form logic
- `lib/pages/product_management_page.dart` - Admin panel
- `main.dart` - Supabase credentials

### Nuclear Option
```bash
flutter clean
rm -rf build/
flutter pub get
flutter run
```

---

## ✅ Verification Checklist

Before concluding there's a bug:
- [ ] Refreshed the page
- [ ] Checked internet connection
- [ ] Verified Supabase is accessible
- [ ] Checked console for error messages
- [ ] Tried on different device
- [ ] Restarted app
- [ ] Checked all form fields valid
- [ ] Verified data in Supabase dashboard

---

## 💡 Pro Tips

1. **Always refresh after major action**
   ```
   Pull-to-refresh in Admin Panel
   Navigate away and back in Home
   ```

2. **Check Supabase dashboard first**
   - Before concluding product not saved
   - Verify data is actually there
   - Check timestamps/metadata

3. **Use browser console**
   ```
   If running on web:
   Right-click → Inspect
   Check Network tab for API calls
   Look for 4xx/5xx status codes
   ```

4. **Mobile device testing**
   - Test on actual phone, not just emulator
   - Emulator might behave differently
   - Some issues only appear on real device

5. **Network monitoring**
   ```
   Use Charles Proxy or similar
   Monitor actual API calls
   Check request/response bodies
   ```

---

## 🚀 Performance Optimization Tips

If app feels slow:

1. **Pagination**: Load products in batches
2. **Caching**: Store data locally with SharedPreferences
3. **Image optimization**: Use smaller images
4. **Lazy loading**: Load images on demand
5. **Index database**: Supabase auto-indexes

---

**Still need help? Check the main README or contact support.** 📞

*Last updated: November 30, 2025*
