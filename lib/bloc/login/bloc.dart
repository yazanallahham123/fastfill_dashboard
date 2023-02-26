import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../model/user/update_firebase_token_body.dart';
import '../../utils/local_data.dart';
import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late ApiClient mClient;

  LoginBloc() : super(InitLoginState()) {
    mClient = ApiClient(certificateClient());
     on<InitEvent>((event, emit){
       InitLoginState();
     });

     on<LoginUserEvent>((event, emit) async {
       try {

         emit(LoadingLoginState());

         await mClient.loginUser(event.loginBody).then((v) async {
           if (v.statusCode == 200) {
             String firebaseTokenText = await getFTokenValue();

             await mClient.updateFirebaseToken("Bearer "+v.value!.token!, UpdateFirebaseTokenBody(firebaseToken: firebaseTokenText));

             if (v.value!.userDetails!.roleId! == 1)
              emit(SuccessLoginState(v));
             else
               emit(ErrorLoginState(
                   translate("messages.phoneNumberOrPasswordIncorrect")));
           }
         });
       } on DioError catch (e) {
         if (e.response != null) {
           if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
             emit(ErrorLoginState(
                 translate("messages.phoneNumberOrPasswordIncorrect")));
           else {
             print("Error" + e.toString());
             emit(ErrorLoginState(dioErrorMessageAdapter(e)));
           }
         }
         else
           {
             emit(ErrorLoginState(dioErrorMessageAdapter(e)));
           }
       }
     });
  }
}


