import 'package:fastfilldashboard/model/company/companies_with_pagination.dart';
import 'package:fastfilldashboard/model/company/company.dart';
import 'package:fastfilldashboard/model/company/payment_transactions_result_with_pagination.dart';
import 'package:fastfilldashboard/model/group/groups_with_pagination.dart';
import 'package:fastfilldashboard/model/notifications/custom_notification_body.dart';
import 'package:fastfilldashboard/model/refills/user_refill_filter.dart';
import 'package:fastfilldashboard/model/refills/user_refills_with_pagination.dart';
import 'package:fastfilldashboard/model/user/payment_transaction_results_filter.dart';
import 'package:fastfilldashboard/model/user/top_up_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../model/company/company_branch.dart';
import '../model/company/company_branches_with_pagination.dart';
import '../model/dashboard/dashboard_data.dart';
import '../model/group/group.dart';
import '../model/login/login_body.dart';
import '../model/login/login_user.dart';
import '../model/notifications/custom_notification_body_to_multiple.dart';
import '../model/notifications/notification_body.dart';
import '../model/notifications/notifications_with_pagination.dart';
import '../model/user/top_up_credit_dto.dart';
import '../model/user/update_firebase_token_body.dart';
import '../model/user/user.dart';
import '../model/user/users_with_pagination.dart';
import 'apis.dart';

part 'retrofit.g.dart';


@RestApi(baseUrl: Apis.baseURL)
@Headers(<String, dynamic>{"Content-Type": "application/json"})
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  //=========== Login ==============

  @POST(Apis.login)
  Future<LoginUser> loginUser(@Body() LoginBody loginBody);

  //User
  @PUT(Apis.updateFirebaseToken)
  Future<String> updateFirebaseToken(@Header("Authorization") String token, @Body() UpdateFirebaseTokenBody updateFirebaseTokenBody);

  //User
  @POST(Apis.addNotification)
  Future<bool> addNotification(@Header("Authorization") String token, @Body() NotificationBody notificationBody);

  //User
  @GET(Apis.getUsers)
  Future<UsersWithPagination> getUsers(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @GET(Apis.getAdministrators)
  Future<UsersWithPagination> getAdministrators(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @PUT(Apis.updateUser)
  Future<String> updateUser(@Header("Authorization") String token, @Body() User user);

  @POST(Apis.insertUser)
  Future<String> insertUser(@Header("Authorization") String token, @Body() User user);

  @DELETE(Apis.user+"/{id}")
  Future<String> deleteUser(@Header("Authorization") String token, @Path("id") int id);


  //User
  @GET(Apis.companiesByName)
  Future<CompaniesWithPagination> getCompaniesByName(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Path("name") String name);

  //User
  @GET(Apis.companyByCode)
  Future<Company> getCompanyByCode(@Header("Authorization") String token, @Path("code") String code);

  //User
  @GET(Apis.allCompanies)
  Future<CompaniesWithPagination> getAllCompanies(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @PUT(Apis.updateCompany)
  Future<String> updateCompany(@Header("Authorization") String token, @Body() Company company);

  @POST(Apis.insertCompany)
  Future<String> insertCompany(@Header("Authorization") String token, @Body() Company company);

  @DELETE(Apis.deleteCompany+"/{id}")
  Future<String> deleteCompany(@Header("Authorization") String token, @Path("id") int id);


  //User
  @GET(Apis.allCompanyBranches)
  Future<CompanyBranchesWithPagination> getAllCompanyBranches(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @GET(Apis.companyBranches+"/{companyId}")
  Future<CompanyBranchesWithPagination> getCompanyBranches(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Path("companyId") int companyId);

  //User
  @PUT(Apis.updateCompanyBranch)
  Future<String> updateCompanyBranch(@Header("Authorization") String token, @Body() CompanyBranch companyBranch);

  @POST(Apis.insertCompanyBranch)
  Future<String> insertCompanyBranch(@Header("Authorization") String token, @Body() CompanyBranch companyBranch);

  @DELETE(Apis.deleteCompanyBranch+"/{id}")
  Future<String> deleteCompanyBranch(@Header("Authorization") String token, @Path("id") int id);

  @GET(Apis.getNotifications)
  Future<NotificationsWithPagination> getNotifications(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @GET(Apis.getCompaniesUsers)
  Future<UsersWithPagination> getCompaniesUsers(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  @GET(Apis.getDashboardData)
  Future<DashboardData> getDashboardData(@Header("Authorization") String token);

  @POST(Apis.topUpCredit)
  Future<TopUpResponse> topUpCredit(@Header("Authorization") String token, @Body() TopUpCreditDto creditDto);

  @POST(Apis.getRefills)
  Future<UserRefillsWithPagination> getRefills(@Header("Authorization") String token, @Body() UserRefillFilter userRefillFilter);

  @POST(Apis.sendCustomNotification)
  Future<bool> sendCustomNotification(@Header("Authorization") String token, @Body() CustomNotificationBody customNotificationBody);

  @POST(Apis.sendCustomNotificationToAll)
  Future<bool> sendCustomNotificationToAll(@Header("Authorization") String token, @Body() CustomNotificationBody customNotificationBody);

  @GET(Apis.getUserById)
  Future<User?> getUserById(@Header("Authorization") String token, @Path("id") int id, @Path("roleId") int roleId);

  @GET(Apis.getUserByMobileNumber)
  Future<User?> getUserByMobileNumber(@Header("Authorization") String token, @Path("mobileNumber") String mobileNumber, @Path("roleId") int roleId);

  @POST(Apis.getPaymentTransactionResults)
  Future<PaymentTransactionResultWithPagination> getPaymentTransactionResults(@Header("Authorization") String token, @Body() PaymentTransactionResultsFilter paymentTransactionResultsFilter);


  //User
  @GET(Apis.groupsByName)
  Future<GroupsWithPagination> getGroupsByName(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Path("name") String name);

  //User
  @GET(Apis.allGroups)
  Future<GroupsWithPagination> getAllGroups(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @PUT(Apis.updateGroup)
  Future<String> updateGroup(@Header("Authorization") String token, @Body() Group group);

  @POST(Apis.insertGroup)
  Future<String> insertGroup(@Header("Authorization") String token, @Body() Group group);

  @DELETE(Apis.deleteGroup+"/{id}")
  Future<String> deleteGroup(@Header("Authorization") String token, @Path("id") int id);

  @POST(Apis.sendCustomNotificationToMultiple)
  Future<bool> sendCustomNotificationToMultiple(@Header("Authorization") String token, @Body() CustomNotificationBodyToMultiple customNotificationBodyToMultiple);

}
