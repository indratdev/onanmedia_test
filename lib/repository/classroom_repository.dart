import 'package:dartz/dartz.dart';
import 'package:onanmedia_test/data/services/fire_service.dart';

class ClassRoomRepository {
  // final UserService userService = UserService();
  final FireService fireService = FireService();

  // READ
  // read list users from firebase
  // Future<List<TablesModel>> readAllTables(String companyID) async {
  //   List<TablesModel> result = await userService.readAllTables(companyID);
  //   return result;
  // }

//   // read list customers from firebase
//   Future<List<CustomersModel>> readAllCustomers() async {
//     String companyID = await readCompanyID();
//     List<CustomersModel> result = await userService.readAllCustomers(companyID);
//     return result;
//   }
//   // END READ

  // --------- CREATE
  // user
  Future<Either<String, String>> createClassRoom(
      String classRoomName, String addBy) async {
    return await fireService.saveNewTable(classRoomName, addBy);
  }

//   // customer
//   Future<Either<String, String>> createNewCustomer(
//       CustomersModel customerModel, String companyID, String uniqueID) async {
//     return await userService.saveNewCustomer(
//         customerModel, companyID, uniqueID);
//   }

//   // END CREATE

//   // -------------- UPDATE
//   Future<Either<String, String>> updateTable(TablesModel tableModel) async {
//     return await userService.updateTable(tableModel);
//   }

// //   // update customer
// //   Future<Either<String, String>> updateCustomer(
// //       CustomersModel customerModel) async {
// //     return await userService.updateCustomer(customerModel);
// //   }
// //   // --------------  END UPDATE

//   // DELETE
//   Future<Either<String, String>> deleteTable(String documentID) async {
//     return await userService.deleteTable(documentID);
//   }

// //   Future<Either<String, String>> deleteCustomer(String customerID) async {
// //     return await userService.deleteCustomer(customerID);
// //   }
// //   // END DELETE
}
