import 'tictac.dart';

class GamePlayController {

  bool hlineWin(List<TicTac> list){
    bool won=false;
    for(int i=0; i<9; i +=3){ // checking every row to see if someone won --> for x -->1, for o -->0
      if((list[i].xoChosen==1 && list[i+1].xoChosen==1 && list[i+2].xoChosen==1) || (list[i].xoChosen==0 && list[i+1].xoChosen==0 && list[i+2].xoChosen==0)){
        won =true;
        break;
      }

    }

    if(won){
    return true;
    }
    else {
      return false;
    }
  }
  bool crossWin(List<TicTac> list){ // we have two way of crossing here '/' and '\'
    bool won=false;
    // checking every column to see if someone won --> for x -->1, for o -->0
      if((list[0].xoChosen==1 && list[4].xoChosen==1 && list[8].xoChosen==1) || (list[0].xoChosen==0 && list[4].xoChosen==0 && list[8].xoChosen==0)){
        won =true;

      }
      else if((list[2].xoChosen==1 && list[4].xoChosen==1 && list[6].xoChosen==1) || (list[2].xoChosen==0 && list[4].xoChosen==0 && list[6].xoChosen==0)){
        won =true;

      }



    if(won){
      return true;}
    else {
      return false;
    }
  }

  bool vlineWin(List<TicTac> list){
    bool won=false;
    for(int i=0; i<3; i +=1){ // checking every column to see if someone won --> for x -->1, for o -->0
      if((list[i].xoChosen==1 && list[i+3].xoChosen==1 && list[i+6].xoChosen==1) || (list[i].xoChosen==0 && list[i+3].xoChosen==0 && list[i+6].xoChosen==0)){
        won =true;
        break;
      }

    }

    if(won){
      return true;}
    else {
      return false;
    }
  }



}