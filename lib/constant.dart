// const baseURL = 'http://192.168.1.6:8000/api';
// const baseURL = 'http://192.168.0.115:8000/api';
const baseURL = 'http://54.255.241.74/api';

const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const totalUser = '$userURL/total';

const patientURL = '$baseURL/patient';
const totalPatientURL = '$patientURL/total';

const riwayatURL = '$baseURL/riwayat-patient';
const riwayatMyPatientURL = '$baseURL/my-riwayat-patient';
const totalRiwayatPatientURL = '$riwayatURL/total';

const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something when wrong, try again!';
