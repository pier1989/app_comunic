enum ResetPasswordResponse {
  ok,
  networkRequestFaild,
  userDisabled,
  userNotFound,
  wrongpassword,
  tooManyReqest,
  unknow,
}

ResetPasswordResponse stringToResetPasswordRespose(String code) {
  switch (code) {
    case "internal-error":
      return ResetPasswordResponse.tooManyReqest;
    case "user-not-found":
      return ResetPasswordResponse.userNotFound;
    case "user-disabled":
      return ResetPasswordResponse.userDisabled;
    case "network-request-failed":
      return ResetPasswordResponse.networkRequestFaild;

    default:
      return ResetPasswordResponse.unknow;
  }
}
