package GUI;

import Singleton.DBSingleton;
import com.mysql.jdbc.StringUtils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;
import java.util.Map;

/**
 * Created by Sheepsheep on 2016-06-13.
 */
public class TabbedPane {
    private JTabbedPane tabbedPane1;
    public JPanel rootpanel;
    private JTextField NewPassportTextField;
    private JTextField NewCusNameTextField;
    private JTextField NewCusPhoneTextField;
    private JTextField NewAirlineTextField;
    private JTextField NewFlightTextField;
    private JButton newCusSubmitButton;
    private JTabbedPane tabbedPane3;
    private JLabel ExistCusPN;
    private JPanel FlightsPanel;
    private JTextField existCusIDTextField;
    private JTextField existCusAirlineTextField;
    private JTextField existCusFlightTextField3;
    private JButton exisCusSubmitButton;
    private JButton SearchAirlineButton;
    private JButton SearchFlightButton;
    private JTextField SearchFlightNumTextField;
    private JTextField SearchFlyFromTextField;
    private JTextField SearchAirlineTextField;
    private JTextField SearchFlyToTextField;
    private JTextField SearchReturnDateTextField;
    private JTextArea SearchFlightTextArea;
    private JTextField CheckCusIDTextField;
    private JTextField CheckAirlineTextField;
    private JTextField CheckFlightTextField;
    private JButton CheckInButton;
    private JTextField CheckConfirNumTextField;
    private JTextField AccountCusIDTextField;
    private JTextArea CusInfoTextArea;
    private JButton AirlineCheckBoardedButton;
    private JButton AirlineCheckInButton;
    private JButton AirlineCheckCancelButton;
    private JTextArea AirlineCusStatusTextArea;
    private JButton AirlineCheckSubmitButton;
    private JTextField AirlineCheckFlightTextField;
    private JTextField AirlineCheckAirTextField;
    private JTextField AIrlineCheckCusIDTextField;
    private JTextField CrewAirlineTextField;
    private JTextField CrewFlightTextField;
    private JTextField CrewIDTextField;
    private JButton assignFlightButton;
    private JTextField AirlineCheckLuggageTypeTextField;
    private JTextField AirlineCheckLuggageWeightTextField;
    private JButton totalNumberOfFlightsButton;
    private JTextArea StatsBox1;
    private JButton averageNumberOfFlightsButton;
    private JTextArea statbox2;
    private JButton updateButton;
    private JTextArea RoyalCustomerArea;
    private JTextField SearchDepartDateTextField;
    private JTextField NewCrewAirTextField;
    private JTextField NewCrewIDTextField;
    private JTextField NewCrewNameTextField;
    private JTextField NewCrewPosiTextField;
    private JButton addCrewMemberButton;
    private JTextField CreateFlightPlaneTextField;
    private JTextField CreateFlightIDTextField;
    private JTextField CreateFlightAirlineTextField;
    private JButton CreateFlightButton;
    private JTextField CreateFromDateTextField;
    private JTextField CreateToDateTextField;
    private JTextField CreateFromWhereTextField;
    private JTextField CreateToWhereTextField;
    private JButton DeleteFlightButton;
    private JTextField CreateFlightDistanceTextField;
    private JButton DeleteCrewMemberButton;
    private JButton CusSubmitButton;
    private JTextField NewCrewPositionTextField;
    private Integer ConfirmationNum;
    private Integer LuggageID;


    public TabbedPane() {
        //Insert new customer and book a flight
        newCusSubmitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String CusID = NewPassportTextField.getText();
                String CusName = NewCusNameTextField.getText();
                String CusPhone = NewCusPhoneTextField.getText();
                String newCusQuery = "insert into Customer (CusID,CusName,PhoneNum,Mileage) values (" + CusID + ",'" + CusName + "','" + CusPhone + "'," + "0);";

                String BookingAirline = NewAirlineTextField.getText();
                String BookingFlightNum = NewFlightTextField.getText();

                //ConfirmationNum = 5000 + random_int()* 9000;
                ConfirmationNum = 5000 + (int)(Math.random() * 10000);




                String bookingQuery = "Insert into Reservation (ConfirmationNum, CusID, FlightNum, Abbreviation) Values (" + ConfirmationNum + ", " + CusID + ", " + BookingFlightNum + ", '" + BookingAirline + "');";
                //ConfirmationNum++;
                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(newCusQuery);
                    DBSingleton.getInstance().ms.ExecuteUpdate(bookingQuery);
                    JOptionPane.showMessageDialog(null, "Booking Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });


        // Book flight for existing customers
        exisCusSubmitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String existCusID = existCusIDTextField.getText();
                String existCusAirline = existCusAirlineTextField.getText();
                String existCusFlight = existCusFlightTextField3.getText();

                ConfirmationNum = 5000 + (int)(Math.random() * 10000);
                String exitCusBookingQuery = "Insert into Reservation (ConfirmationNum, CusID, FlightNum, Abbreviation) Values (" + ConfirmationNum + ", " + existCusID + ", " + existCusFlight + ", '" + existCusAirline + "');";

                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(exitCusBookingQuery);
                    JOptionPane.showMessageDialog(null, "Booking Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });


        // check in online
        CheckInButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String CheckCusID = CheckCusIDTextField.getText();
                String CheckAirline = CheckAirlineTextField.getText();
                String CheckFlight = CheckFlightTextField.getText();
                String CheckConfirmNum = CheckConfirNumTextField.getText();

                String DeleteInReservation = "delete from Reservation where ConfirmationNum =" + CheckConfirmNum + ";";
                String CusCheckIn = "Insert into CheckIn (CusID,FlightNum,CusStatus,Abbreviation) Values(" + CheckCusID + "," + CheckFlight + ",'check-in', '" + CheckAirline + "');";
                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(CusCheckIn);
                    DBSingleton.getInstance().ms.ExecuteUpdate(DeleteInReservation);

                    JOptionPane.showMessageDialog(null, "Check-In Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }


            }
        });


        AirlineCheckInButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String AirCheckLuggageType = AirlineCheckLuggageTypeTextField.getText();
                String AirCheckLuggageWeight = AirlineCheckLuggageWeightTextField.getText();
                String AirCheckCusID = AIrlineCheckCusIDTextField.getText();


                String AirCheckFlightNum = AirlineCheckFlightTextField.getText();
                String AirCheckAir = AirlineCheckAirTextField.getText();


                LuggageID = 300000 + (int)(Math.random() * 100000);

                String CheckInLuggage = "Insert into Luggage(LuggageID, Weight, LuggageStatus, LuggageType, CusID) values(" + LuggageID + "," + AirCheckLuggageWeight + ",'check-in','" + AirCheckLuggageType + "'," + AirCheckCusID + ");";

                String CheckInCustomer = "Insert into CheckIn (CusID,FlightNum,CusStatus,Abbreviation) Values(" + AirCheckCusID + "," + AirCheckFlightNum + ",'check-in', '" + AirCheckAir + "');";
                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(CheckInLuggage);
                    DBSingleton.getInstance().ms.ExecuteUpdate(CheckInCustomer);

                    JOptionPane.showMessageDialog(null, "Check-In Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }


            }
        });
        AirlineCheckBoardedButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String AirCheckCusID = AIrlineCheckCusIDTextField.getText();
                String AirCheckFlightNum = AirlineCheckFlightTextField.getText();
                String AirCheckAir = AirlineCheckAirTextField.getText();

                String AirCancelQuery = "Update Checkin set Cusstatus = 'boarded' where CusID="+AirCheckCusID+" and FlightNum="+AirCheckFlightNum+"  and  Abbreviation = '"+AirCheckAir+"';";

                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(AirCancelQuery);
                    JOptionPane.showMessageDialog(null, "Customer boarded!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });
        AirlineCheckCancelButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String AirCheckCusID = AIrlineCheckCusIDTextField.getText();
                String AirCheckFlightNum = AirlineCheckFlightTextField.getText();
                String AirCheckAir = AirlineCheckAirTextField.getText();

                String AirCancelQuery = "Update Checkin set Cusstatus = 'Cancel' where CusID="+AirCheckCusID+" and FlightNum="+AirCheckFlightNum+"  and  Abbreviation = '"+AirCheckAir+"';";

                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(AirCancelQuery);
                    JOptionPane.showMessageDialog(null, "Customer Canceled!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });
        addCrewMemberButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String NewCrewAir = NewCrewAirTextField.getText();
                String NewCrewID = NewCrewIDTextField.getText();
                String NewCrewName = NewCrewNameTextField.getText();
                String NewCrewPosition = NewCrewPositionTextField.getText();

               String NewCrewQuery = "Insert into CrewMemberFor(CrewID, CrewPosition, CrewName, Abbreviation) values ("+NewCrewID+", '"+NewCrewPosition+"', '"+NewCrewName+"','"+NewCrewAir+"');";

                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(NewCrewQuery);
                    JOptionPane.showMessageDialog(null, "Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }


            }
        });
        assignFlightButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String CrewAirline = CrewAirlineTextField.getText();
                String CrewFlight = CrewFlightTextField.getText();
                String CrewID =CrewIDTextField.getText();

                String AssignFlight = "Insert into HasCrewMember (FlightNum, Abbreviation,CrewId)values ("+CrewFlight+", '"+CrewAirline+"', "+CrewID+");";

                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(AssignFlight);
                    JOptionPane.showMessageDialog(null, "Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });

        CreateFlightButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String FlightAirline = CreateFlightAirlineTextField.getText();
                String FlightPlane = CreateFlightPlaneTextField.getText();
                String FlightID = CreateFlightIDTextField.getText();
                String FlightFromDate = CreateFromDateTextField.getText();
                String FlightToDate = CreateToDateTextField.getText();
                String FlightFromWhere = CreateFromWhereTextField.getText();
                String FlightToWhere = CreateToWhereTextField.getText();
                String FlightDistance = CreateFlightDistanceTextField.getText();

                int checkFlightNum = Integer.parseInt(FlightID);

                if(checkFlightNum<0){                               ///////////Check Constrain that flight number can not be less than 0;

                        JOptionPane.showMessageDialog(null, "Invalid Input! Flight # Must be Greater than 0!");
                        return;
                }


                String CreateFlightQuery = "Insert into Flight(FlightNum, Distance, ToDateTime, FromDateTime, ToWhere, FromWhere, PlaneID, Abbreviation) " +
                        "values ( "+FlightID+","+FlightDistance+","+FlightToDate+" ,"+FlightFromDate+",'"+FlightToWhere+"','"+FlightFromWhere+"',"+FlightPlane+" ,'"+FlightAirline+"');";
                try {


                        DBSingleton.getInstance().ms.ExecuteUpdate(CreateFlightQuery);
                    JOptionPane.showMessageDialog(null, "Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }

            }
        });


        DeleteFlightButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String FlightAirline = CreateFlightAirlineTextField.getText();
                String FlightID = CreateFlightIDTextField.getText();
                String FlightFromDate = CreateFromDateTextField.getText();

                String DeleteFlightQuery = "Delete from Flight where FlightNum="+FlightID+" and FromDateTime="+FlightFromDate+" and Abbreviation= '"+FlightAirline+"';";
                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(DeleteFlightQuery);
                    JOptionPane.showMessageDialog(null, "Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });
        DeleteCrewMemberButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String DeleteCrewID = NewCrewIDTextField.getText();
                String DeleteCrewAir = NewCrewAirTextField.getText();

                String DeleteCrewMember = "Delete from CrewMemberFor where CrewID ="+DeleteCrewID+" and Abbreviation = '"+DeleteCrewAir+"';";
                try {
                    DBSingleton.getInstance().ms.ExecuteUpdate(DeleteCrewMember);
                    JOptionPane.showMessageDialog(null, "Success!");
                } catch (Exception e1) {
                    JOptionPane.showMessageDialog(null, "Invalid Input!");
                    e1.printStackTrace();
                }
            }
        });

        totalNumberOfFlightsButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String totalFlights = "Select ToWhere, count(FlightNum) as count from Flight group by ToWhere order by count desc";

                try {
                    List<Map<String, String>> lis = DBSingleton.getInstance().ms.ExecuteQuery(totalFlights);
                    StringBuilder sb = new StringBuilder();
                    Object[] keys = lis.get(0).keySet().toArray();
                    /*for (Object s : keys) {
                        sb.append((String) s + "  ");
                    }
                    sb.append("\n");*/
                    for (Map<String, String> m : lis) {
                        for (Object s : keys) {
                            sb.append(m.get((String) s) + "      \t");
                        }
                        sb.append("\n");
                    }

                    StatsBox1.setText(sb.toString());
                } catch (Exception e1) {

                    e1.printStackTrace();
                }
            }
        });
        averageNumberOfFlightsButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String averageFlights = "Select AirlineName, avg(temp.count)  as NumberofFlights\n" +
                        "from  (Select CusID, Abbreviation, count(ConfirmationNum)as count\n" +
                        "From Reservation natural join Flight\n" +
                        "Group by CusID, Abbreviation) as temp, airlines a\n" +
                        "where a.Abbreviation=temp.Abbreviation\n" +
                        "group by AirlineName\n" +
                        "order by count desc";

                try {
                    List<Map<String, String>> lis = DBSingleton.getInstance().ms.ExecuteQuery(averageFlights);
                    StringBuilder sb = new StringBuilder();
                    Object[] keys = lis.get(0).keySet().toArray();
                    /*for (Object s : keys) {
                        sb.append((String) s + "  ");
                    }
                    sb.append("  \n");*/
                    for (Map<String, String> m : lis) {
                        for (Object s : keys) {
                            sb.append(m.get((String) s) + "\t");
                        }
                        sb.append("\n");
                    }

                    statbox2.setText(sb.toString());
                } catch (Exception e1) {

                    e1.printStackTrace();
                }
            }

        });

        updateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String royalCustomer = "SELECT DISTINCT C.CusName, F.Abbreviation, F.PlaneID FROM Customer C\n" +
                        "Natural JOIN Reservation R Natural Join Flight F\n" +
                        "GROUP BY C.CusName\n" +
                        "HAVING COUNT(*) = (\n" +
                        "  SELECT COUNT(*) FROM Customer C2\n" +
                        "  WHERE C.CusName=C2.CusName\n" +
                        ")";

                try {
                    List<Map<String, String>> lis = DBSingleton.getInstance().ms.ExecuteQuery(royalCustomer);
                    StringBuilder sb = new StringBuilder();
                    Object[] keys = lis.get(0).keySet().toArray();
                /*    for (Object s : keys) {
                        sb.append((String) s + "  ");
                    }
                    sb.append("  \n");*/
                    for (Map<String, String> m : lis) {
                        for (Object s : keys) {
                            sb.append(m.get((String) s) + "   \t");
                        }
                        sb.append("\n");
                    }

                    RoyalCustomerArea.setText(sb.toString());
                } catch (Exception e1) {

                    e1.printStackTrace();
                }

            }
        });
        SearchFlightButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String flyingFrom = SearchFlyFromTextField.getText();
                String flyingTo = SearchFlyToTextField.getText();
                String returnDate = SearchDepartDateTextField.getText();
                String departDate = SearchReturnDateTextField.getText();

                String srAirline = SearchAirlineTextField.getText();
                String srFlight = SearchFlightNumTextField.getText();
                String query = "select * from Flight where 1=1 ";


                if (flyingTo.length() > 0){
                    query = query.concat("and ToWhere = '" + flyingTo+"'");
                    System.out.println(query);
                }
                if (flyingFrom.length() > 0){
                    query = query.concat("and FromWhere = '" + flyingFrom+"'");
                }
                if (returnDate.length() > 0){
                    query = query.concat("and ToDateTime = " + departDate);
                }
                if (departDate.length() > 0){
                    query = query.concat("and FromDateTime = " + returnDate);
                }
                if (srAirline.length() > 0){
                    query = query.concat("and Abbreviation = '" + srAirline+"'");
                    System.out.println(query);
                }
                if (srFlight.length() > 0){
                    query = query.concat("and FlightNum = '" + srFlight+"'");
                    System.out.println(query);
                }
                query = query.concat(";");
                System.out.println(query);



                try {
                    List<Map<String, String>> lis = DBSingleton.getInstance().ms.ExecuteQuery(query);
                    StringBuilder sb = new StringBuilder();
                    Object[] keys = lis.get(0).keySet().toArray();
                    /*for (Object s : keys) {
                        sb.append((String) s + "  ");
                    }
                    sb.append("\n");*/
                    for (Map<String, String> m : lis) {
                        for (Object s : keys) {
                            sb.append(m.get((String) s) + "       ");
                        }
                        sb.append("\n");
                    }

                    SearchFlightTextArea.setText(sb.toString());
                } catch (Exception e1) {

                    e1.printStackTrace();
                }
            }
        });
        CusSubmitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String CusID = AccountCusIDTextField.getText();

                String CusQuery =
                        "Select M.Abbreviation, M.FlightNum, M.ConfirmationNum, M.CusStatus, F.FromWhere, F.ToWhere, F.fromDateTime    From MyAccount M Natural Join Flight F     Where CusID="+CusID+"";

                try {
                    List<Map<String, String>> lis = DBSingleton.getInstance().ms.ExecuteQuery(CusQuery);
                    StringBuilder sb = new StringBuilder();
                    Object[] keys = lis.get(0).keySet().toArray();
                    /*for (Object s : keys) {
                        sb.append((String) s + "  ");
                    }
                    sb.append("\n");*/
                    for (Map<String, String> m : lis) {
                        for (Object s : keys) {
                           // String temp = String.format("%-8s", s );


                            sb.append(m.get(s) + "         ");

                        }
                        sb.append("\n");
                    }

                    CusInfoTextArea.setText(sb.toString());
                } catch (Exception e1) {

                    e1.printStackTrace();
                }
            }
        });
    }
}
