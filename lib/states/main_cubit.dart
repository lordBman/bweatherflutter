import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MainState extends Equatable{
    final int index, pageIndex;
    final bool __showFAO;
    
    bool get showFAO => __showFAO && pageIndex == 1;

    const MainState({ this.index = 0, this.pageIndex = 0, bool showFAO = true }): __showFAO = showFAO;

    MainState copy({ int? index, int? pageIndex, bool? showFAO }){
        return MainState(index: index ?? this.index, pageIndex: pageIndex ?? this.pageIndex, showFAO: showFAO ?? __showFAO);
    }
    
    @override
    List<Object?> get props => [index, pageIndex, __showFAO];
}


class MainCubit extends Cubit<MainState>{
    set index(int index){
        emit(state.copy(index: index, pageIndex: 0, showFAO: false));
    }

    set pageIndex(int index){
        emit(state.copy(pageIndex: index, showFAO: index == 1));
    }

    set showFAO(bool value){
        if(state.__showFAO != value){
            emit(state.copy(showFAO: value));
        }
    }

    MainCubit(): super(const MainState());
}