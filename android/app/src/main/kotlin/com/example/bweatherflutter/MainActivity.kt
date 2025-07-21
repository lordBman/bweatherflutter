package com.example.bweatherflutter

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat

import com.example.bweatherflutter.R

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.graphics.BitmapFactory
import android.graphics.Bitmap
import android.graphics.Canvas
import com.caverock.androidsvg.SVG
import java.io.InputStream

class MainActivity : FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example/native").setMethodCallHandler{ call, result ->
            if(call.method == "getNativeData"){
                result.success("Data from Android Native Code")
            }else{
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example/notification").setMethodCallHandler{ call, result ->
            if (call.method == "showNotification") {
                val title = call.argument<String>("title")
                val message = call.argument<String>("message")

                if (title != null && message != null) {
                    showNotification(title, message)
                    result.success(null) // Notify Flutter that the function was executed successfully
                } else {
                    result.error("INVALID_ARGUMENTS", "Title or message missing", null)
                }
            }else{
                result.notImplemented()
            }
        }
    }

    private fun showNotification(title: String, message: String) {
        val channelId = "flutter_notifications"
        val channelName = "Flutter Notifications"
        val notificationId = 1

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Create a notification channel (required for Android 8.0+)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val channel = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_DEFAULT)
            notificationManager.createNotificationChannel(channel)
        }

        // Create an intent to open the app when the notification is tapped
        val intent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE)

        // Load the Flutter asset (SVG) and convert it to a Bitmap
        val icon = loadFlutterAsset("files/ic_splash.png")

        // Build the notification
        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle(title)
            .setContentText(message)
            .setSmallIcon(R.mipmap.ic_launcher) // Replace with your app's icon
            //.setLargeIcon(icon) // Use the SVG asset as the large icon
            .setStyle(NotificationCompat.BigPictureStyle()
                .bigPicture(icon))
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .build()

        // Show the notification
        notificationManager.notify(notificationId, notification)
    }

    private fun loadFlutterAsset(assetPath: String): Bitmap? {
        return try {
            val assetManager = assets
            val inputStream: InputStream = assetManager.open(assetPath)
            BitmapFactory.decodeStream(inputStream)
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

    private fun loadSvgAsBitmap(assetPath: String, width: Int, height: Int): Bitmap? {
        return try {
            val assetManager = assets
            val inputStream: InputStream = assetManager.open(assetPath)

            // Parse the SVG
            val svg = SVG.getFromInputStream(inputStream)

            // Set the canvas size
            svg.documentWidth = width.toFloat()
            svg.documentHeight = height.toFloat()

            // Create a bitmap and canvas
            val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            val canvas = Canvas(bitmap)

            // Render the SVG onto the canvas
            svg.renderToCanvas(canvas)

            bitmap
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
}
