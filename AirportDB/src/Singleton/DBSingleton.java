package Singleton;

        import DBHelper.MySQLAccess;

/**
 * Created by Sheepsheep on 2016-06-12.
 */
public class DBSingleton {
    private static DBSingleton instance = null;
    private  final static String connectionString = "jdbc:mysql://localhost/Airport?"
            + "user=root&password=1234";
    public static MySQLAccess ms;
    private DBSingleton(){
        ms = new MySQLAccess(connectionString);
    }
    public  static  DBSingleton getInstance(){
        if(instance == null){
            instance = new DBSingleton();
        }
        return instance;
    }
}
