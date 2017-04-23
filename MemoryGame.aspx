<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MemoryGame.aspx.cs" Inherits="MemoryGame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" ng-app="SoftwareDevelopmentNo5App">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="jquery-ui-1.12.1.custom/jquery-ui.css" />
    <script src="js/angular.js"></script>
    <script src="js/app.js"></script>
    <script src="js/PlayCard.js"></script>
    <script src="jquery-ui-1.12.1.custom/external/jquery/jquery.js"></script>
    <script src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script language="javascript">
        var dialog;
        $(function () {
            function EnterRankings() {
                var Argument = $("#name").val() + "_" + $("#PlayerTime").html();
                Sys.WebForms.PageRequestManager.getInstance().beginAsyncPostBack(null, "EnterRankings", Argument);
                dialog.dialog("close");
                location.reload();
            }
            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 450,
                width: 400,
                modal: true,
                buttons: {
                    "成為排行榜的一員!": EnterRankings
                },
                close: function () {
                }
            });
        })
    </script>
</head>
<body style='background-color: #DBDBDB;' ng-controller="GameCtrl">
    <div id="dialog-form" title="擠進積分榜!">
        <form>
            <fieldset>
                <label for="name">暱稱</label>
                <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
                <div>&nbsp;</div>
                <label>成績：</label>
                <label id="PlayerTime"></label>
                <!-- Allow form submission with keyboard without duplicating the dialog button -->
                <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" />
            </fieldset>
        </form>
    </div>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div style='background-image: url(img/banner.jpg); background-repeat: no-repeat; width: 100%; height: 237px; background-color: #59514E;'></div>
        <div style='width: 100%; height: 5px; background-color: #FFA488;'></div>
        </br></br>
        <div style='float: right; margin-right: 50px;'>
            <div style='float: right;'>
                <div style='background-color: #F2A851;' align='right'><b>剩餘 {{game.UnMatchedCard}} 組需要配對</b></div>
                <div style='background-color: #FFFD62;' align='left' id="timetag"><b>秒數：0</b></div>
            </div>
            <div style="text-align: center; margin-top: 100px; margin-bottom: 5px;"><b>排行榜</b></div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvRank" runat="server" AutoGenerateColumns="False" ClientIDMode="Static"
                        CssClass="gvDGD" GridLines="None" AllowPaging="True" PageSize="5">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblAWB_LIST_Temp" runat="server" ClientIDMode="Static"
                                        Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    暱稱                                                
                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblAWB_LIST_MSDS" runat="server" ClientIDMode="Static"
                                        Text='<%# Bind("TIME") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    時間(秒)
                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblAWB_LIST_IL" runat="server" ClientIDMode="Static"
                                        Text='<%# Bind("DATE") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    日期
                                </HeaderTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="PagerCss" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <table align='center'>
            <tr ng-repeat="card in game.order">
                <td ng-repeat="tile in card" ng-click="game.flipTile(tile)">
                    <div class="container">
                        <div class="card" ng-class="{flipped: tile.flipped}">
                            <img class="front" style="cursor: pointer" ng-src="img/back.png">
                            <img class="back" ng-src="img/{{tile.title}}.png">
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <div style='width: 100%; height: 5px; background-color: #FFA488;'></div>
        <div style='background-image: url(img/intro.jpg); background-repeat: no-repeat; width: 100%; height: 150px; background-color: #59514E;'></div>
        <div style='width: 100%; height: 5px; background-color: #FFA488;'></div>
        <br />
        <div class="s_c">
            <ul>
                <li>
                    <div id="m1" class="c_1" style="cursor: pointer">
                        <a onclick="CollectionChange(1)">
                            <img width="100px" src="img/title-01.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m2" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(2)">
                            <img width="100px" src="img/title-02.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m3" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(3)">
                            <img width="100px" src="img/title-03.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m4" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(4)">
                            <img width="100px" src="img/title-04.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m5" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(5)">
                            <img width="100px" src="img/title-05.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m6" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(6)">
                            <img width="100px" src="img/title-06.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m7" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(7)">
                            <img width="100px" src="img/title-07.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m8" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(8)">
                            <img width="100px" src="img/title-08.jpg" border="0"></a>
                    </div>
                </li>
                <li>
                    <div id="m9" class="c_0" style="cursor: pointer">
                        <a onclick="CollectionChange(9)">
                            <img width="100px" src="img/title-09.jpg" border="0"/></a>
                    </div>
                </li>
            </ul>
        </div>
        <br/>
<br/>
<br/>
<br/>
<br/>
<br/>
        <div style='width: 100%; height: 400px; background-color: #7F7774;' class="s_b">

            <div class="block" id="s1">
                <div style='background-image: url(img/intro-01.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s2">
                <div style='background-image: url(img/intro-02.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s3">
                <div style='background-image: url(img/intro-03.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s4">
                <div style='background-image: url(img/intro-04.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s5">
                <div style='background-image: url(img/intro-05.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s6">
                <div style='background-image: url(img/intro-06.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s7">
                <div style='background-image: url(img/intro-07.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s8">
                <div style='background-image: url(img/intro-08.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
            <div class="none" id="s9">
                <div style='background-image: url(img/intro-09.jpg); background-repeat: no-repeat; width: 100%; height: 400px; background-color: #7F7774;'></div>
            </div>
        </div>
        <script type="text/javascript">
            function ConfirmAWB_NUM() {
                Sys.WebForms.PageRequestManager.getInstance().beginAsyncPostBack(
 null, "uploadEnd", null);}
        </script>
    </form>
</body>
</html>
