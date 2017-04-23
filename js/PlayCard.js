//參考網址 https://github.com/IgorMinar/Memory-Game
flag = true; //game.flipTile中的判斷是否執行time()的變數
timeropen = true; //計時器是否啟動的判斷值
Time = 0;//秒數
timerend = false;//計時器是否關閉的判斷值
var t;//setInterval的變數名稱
  Game.Continue = 'Not Over';//判斷遊戲是否結束
  Game.WON = 'You win!';//判斷遊戲是否結束
  function Tile(title) {
  this.title = title;
  this.flipped = false;
}
Tile.prototype.flip = function() {
  this.flipped = !this.flipped;
}
function Game(CardNames) {
  var TheGameDeck = MakeDeck(CardNames);
  this.order = MakeOrder(TheGameDeck);
  this.UnMatchedCard = CardNames.length;
  this.Progress = Game.Continue;
  this.flipTile = function(OneOfCard) {
    if (OneOfCard.flipped) {
      return;
    }
	if (flag){
	t = setInterval("TimedCount()", 1000);//遊戲開始開始計時
	flag = false ;
	}
    OneOfCard.flip();
    if (!this.First || this.Second) {
      if (this.Second) {
        this.First.flip();
        this.Second.flip();
        this.First = this.Second = undefined;
      }
      this.First = OneOfCard;
    } else {
      if (this.First.title === OneOfCard.title) {
        this.UnMatchedCard--;
        this.Progress = (this.UnMatchedCard > 0) ? Game.Continue : Game.WON;
        this.First = this.Second = undefined;
      } else {
        this.Second = OneOfCard;
      }
    }
	if (this.Progress === Game.WON) 
	{
	    timerend = true;
	}
  }
}
function MakeDeck(CardNames) {
  var tileDeck = [];
  CardNames.forEach(function(name) {
    tileDeck.push(new Tile(name));
    tileDeck.push(new Tile(name));
  });

  return tileDeck;
}
function MakeOrder(TheGameDeck) {
  var gridDimension = Math.sqrt(TheGameDeck.length),
      grid = [];
  for (var card = 0; card < gridDimension; card++) {
    grid[card] = [];
    for (var col = 0; col < gridDimension; col++) {
        grid[card][col] = removeRandomTile(TheGameDeck);
    }
  }
  return grid;
}
function removeRandomTile(TheGameDeck) {
  var i = Math.floor(Math.random()*TheGameDeck.length);
  return TheGameDeck.splice(i, 1)[0];
}
function TimedCount() {
    if (timerend) {
        clearInterval(t);
        Sys.WebForms.PageRequestManager.getInstance().beginAsyncPostBack(
null, "CheckRank", Time.toString()
);
        return;
    }
    Time = Time + 1;
    document.getElementById('timetag').innerHTML = "<b>秒數：" + Time + "</b>";   
}
function CollectionChange(s_id) {
    for (i = 1; i < 10; i++) {
        if (i == s_id) {
            document.getElementById("s" + i).className = "block"; //內容樣式
            document.getElementById("m" + i).className = "c_" + i + " c_1"; //標題樣式
        }
        else {
            document.getElementById("s" + i).className = "none"; //不顯示
            document.getElementById("m" + i).className = "c_0"; //
        }
    }
}
function OpenEnterRankingsDialog() {
    document.getElementById('PlayerTime').innerHTML = Time;
    dialog.dialog("open");
}
function OpenCompleteDialog() {
    alert('完成了!  可惜沒有進入排行榜');
    location.reload();
}
