/* 请在适当的位置补充代码，完成指定的任务 
   提示：
      try {


      } catch
    之间补充代码  
*/
import java.sql.*;

public class Client {
    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://127.0.0.1:3306/finance?useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
            String username = "root";
            String password = "123123";
            //定义连结类型，用户名，密码
            connection = DriverManager.getConnection(url, username, password);
            //创建连结对象
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select c_name, c_mail, c_phone from client where c_mail is not null");
            //结果集
            System.out.println("姓名\t邮箱\t\t\t\t电话");
            while (resultSet.next()) {  
                System.out.println(resultSet.getString("c_name")+"\t"+resultSet.getString("c_mail")+"\t\t"+resultSet.getString("c_phone")); 
            }//游标遍历输出结果
         } catch (ClassNotFoundException e) {
            System.out.println("Sorry,can`t find the JDBC Driver!"); 
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
