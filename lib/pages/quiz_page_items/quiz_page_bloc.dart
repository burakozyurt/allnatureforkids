import 'package:allnatureforkids/models/quiz_data_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_repository.dart';
import 'package:allnatureforkids/shared/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class QuizPageBloc extends Bloc{
  QuizPageRepository _quizPageRepository = QuizPageRepository();

  final _quizDataListFetcher = BehaviorSubject<List<QuizDataModel>>();

  Stream<List<QuizDataModel>> get quizDataModelListStream => _quizDataListFetcher;

  fetchAllData(String sectionIdName,{int length = 5})async{
    List<QuizDataModel> quizDataModelList = await _quizPageRepository.getQuizDataModelList(sectionIdName,length: length);

    if(!_quizDataListFetcher.isClosed){
      _quizDataListFetcher.sink.add(quizDataModelList);
    }
  }

  shuffleQuiznDataList()async{
    List<QuizDataModel> sectionDataModelList = await _quizDataListFetcher.first;
    sectionDataModelList.shuffle();
    if(!_quizDataListFetcher.isClosed){
      _quizDataListFetcher.sink.add(sectionDataModelList);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
  close(){
    _quizDataListFetcher.close();
  }
}