import UIKit
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.granitesoft.staulker"]
  
  let BG_DATE_KEY: String = "bgDate"
  let userDefaults = UserDefaults.standard
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    //**-Register BG Task
    BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.granitesoft.staulker", using: nil) { task in
      // Downcast the parameter to an app refresh task as this identifier is used for a refresh request.
      self.handleAppRefresh(task: task as! BGAppRefreshTask)
    }
    
    return true
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    print("applicationDidEnterBackground")
    scheduleAppRefresh()
  }
  
  // MARK: - Scheduling Tasks
  //**-could also submit background processing tasks like db cleanup
  func scheduleAppRefresh() {
    print("in scheduleAppRefresh ")
    let request = BGAppRefreshTaskRequest(identifier: "com.granitesoft.staulker")
    request.earliestBeginDate = Date(timeIntervalSinceNow: 60) // Fetch no earlier than 1 minutes from now

    do {
      try BGTaskScheduler.shared.submit(request)
      print("scheduleAppRefresh: request submitted ")

    } catch {
      print("Could not schedule app refresh: \(error)")
    }
  }
  
  
  //MARK: Refresh Task
  //**-Fetch the latest feed entries from server.
  func handleAppRefresh(task: BGAppRefreshTask) {
    //**-critical as this schedules another the next bg refresh
    // oterwise bg is scheduled only once each time I open app
    scheduleAppRefresh()
    
    // do refresh here
    saveBGDate()
    
    //**-ensure this is here in case os cancels the task
    task.expirationHandler = {
      // After all operations are cancelled, the completion block below is called to set the task to complete.
      // make sure this is available
      // cleanup connections etc here

    }
    
    // **-ensure to call setTaskCompleted when done with work
    // or OS may not launch you in future
    // set succseess when task is completed e.g.updating stocl prices
    task.setTaskCompleted(success: true)
  } // handle app refresh
  
  func saveBGDate() {
    
    print("Saving BG Date as String")
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d h:mm a"
    dateFormatter.locale = Locale(identifier: "en_US")       // US English Locale (en_US)
    
    let bgDate = dateFormatter.string(from: Date())
    print("Saving: \(bgDate)")
    self.userDefaults.set(bgDate, forKey: BG_DATE_KEY)
  }
} // end AppDelegate

