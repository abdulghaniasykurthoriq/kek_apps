import 'package:flutter/material.dart';

class DiagnosisProvider extends ChangeNotifier {
  String _resultDiagnosis = "";
  String get resultDiagnosis => _resultDiagnosis;
  void updateResultDiagnosis(String value) {
    _resultDiagnosis = value;
    // notifyListeners();
  }

  double _ukuranLila = 0;
  double get ukuranLila => _ukuranLila;
  void updateUkuranLila(double value) {
    _ukuranLila = value;
    // notifyListeners();
  }

  double _tinggiBadan = 0;
  double get tinggiBadan => _tinggiBadan;
  void updateTingginBadan(double value) {
    _tinggiBadan = value;
    // notifyListeners();
  }

  double _beratBadanSebelumHamil = 0;
  double get beratBadanSebelumHamil => _beratBadanSebelumHamil;
  void updateBeratBadanSebelumHamil(double value) {
    _beratBadanSebelumHamil = value;
    // notifyListeners();
  }

  double _indeksMasaTubuh = 0;
  double get indeksMasaTubuh => _indeksMasaTubuh;
  void updateIndeksMasaTubuh(double value) {
    _indeksMasaTubuh = value;
  }

  double _beratBadanTrimesterHamil = 0;
  double get beratBadanTrimesterHamil => _beratBadanTrimesterHamil;
  void updateBeratBadanTrimesterHamil(double value) {
    _beratBadanTrimesterHamil = value;
    // notifyListeners();
  }

  double _kadarHemoglobin = 0;
  double get kadarHemoglobin => _kadarHemoglobin;
  void updateKadarHemoglobin(double value) {
    _kadarHemoglobin = value;
    // notifyListeners();
  }

  int _gravida = 0;
  int get gravida => _gravida;
  void updateGravida(int value) {
    _gravida = value;
    // notifyListeners();
  }

  int _para = 0;
  int get para => _para;
  void updatePara(int value) {
    _para = value;
    // notifyListeners();
  }

  int _abortus = 0;
  int get abortus => _abortus;
  void updateAbortus(int value) {
    _abortus = value;
    // notifyListeners();
  }
}
