package DBHelper;

import javax.swing.table.AbstractTableModel;
import java.sql.*;
import java.util.*;


public class MySQLAccess {
    private Connection connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;
    private  String connectionString;
    public MySQLAccess(String connection){
        this.connectionString = connection;
    }

    public List<Map<String,String>> ExecuteQuery(String query) throws Exception{
        List<Map<String,String>> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager
                    .getConnection(connectionString);
            statement = connect.createStatement();
            resultSet = statement
                    .executeQuery(query);
            if(resultSet == null )
                return list;
            ResultSetMetaData rsmd = resultSet.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            while (resultSet.next()) {
                Map<String,String> dic = new HashMap<>();
                for(int i = 0; i< columnsNumber; i++){
                    String key = rsmd.getColumnName(i+1);
                    dic.put(key, resultSet.getString(key));
                }
               list.add(dic);
            }
            return list;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            close();
        }
    }

    //for insert and delete
    public void ExecuteUpdate(String query) throws Exception{
        List<Map<String,String>> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager
                    .getConnection(connectionString);
            statement = connect.createStatement();
            statement.executeUpdate(query);

        }
        catch (Exception e) {
            throw e;
        }
        finally {
            close();
        }
    }



    // You need to close the resultSet
    private void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }

}
