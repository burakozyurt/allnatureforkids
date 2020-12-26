import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_repository.dart';
import 'package:allnatureforkids/shared/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class LearningPageBloc extends Bloc{
  LearningPageRepository _learningPageRepository = LearningPageRepository();

  final _sectionDataListFetcher = BehaviorSubject<List<SectionDataModel>>();

  Stream<List<SectionDataModel>> get sectionDataModelListStream => _sectionDataListFetcher;

  fetchAllData(String sectionIdName)async{
    List<SectionDataModel> sectionDataModelList = await _learningPageRepository.getSectionDataModelList(sectionIdName);

    if(!_sectionDataListFetcher.isClosed){
      _sectionDataListFetcher.sink.add(sectionDataModelList);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
  close(){
    _sectionDataListFetcher.close();
  }
}