unit principale;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Ani, FMX.Controls3D, FMX.Objects3D,
  FMX.Viewport3D, FMX.MaterialSources, FMX.Types3D, uNiveau, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects, System.Actions, FMX.ActnList, System.IOUtils,
  FMX.ListBox;

type
  TfPrincipale = class(TForm)
    affichage3D: TViewport3D;
    dmyScene: TDummy;
    aniPrincipale: TFloatAnimation;
    zoneJeu: TStrokeCube;
    dmyJoueur: TDummy;
    Camera: TCamera;
    Balle: TSphere;
    sol: TPlane;
    gauche: TPlane;
    droit: TPlane;
    plafond: TPlane;
    lmsBalle: TLightMaterialSource;
    lumiereNiveau: TLight;
    modeleObstacle: TRectangle3D;
    lmsObstacle: TLightMaterialSource;
    raquetteJoueur: TStrokeCube;
    aniCouleurContact: TColorKeyAnimation;
    fond: TPlane;
    ombre: TDisk;
    cmsOmbre: TColorMaterialSource;
    layInfos: TLayout;
    layVie: TLayout;
    RoundRect1: TRoundRect;
    Circle1: TCircle;
    Circle3: TCircle;
    Circle2: TCircle;
    lNomNiveau: TLabel;
    layMessage: TLayout;
    panneauMessage: TRectangle;
    lMessage: TLabel;
    aniTransition: TFloatAnimation;
    DissolveTransitionEffect1: TDissolveTransitionEffect;
    ActionList1: TActionList;
    actJouer: TAction;
    actQuitter: TAction;
    dmyIntro: TDummy;
    lIntro: TText3D;
    layMenu: TLayout;
    recMenu: TRectangle;
    Button1: TButton;
    Button5: TButton;
    layIntroMessage: TLayout;
    lblIntroMessage: TLabel;
    tmsArrivee: TTextureMaterialSource;
    arrivee: TPlane;
    depart: TPlane;
    cmsDepart: TColorMaterialSource;
    lmsTunnel: TLightMaterialSource;
    lumiereIntro: TLight;
    modeleBonusAgrandir: TStrokeCube;
    modeleBonusReduire: TStrokeCube;
    modeleBonusVie: TStrokeCube;
    Circle4: TCircle;
    Circle5: TCircle;
    layRebond: TLayout;
    lRebond: TLabel;
    actSelectionnerNiveau: TAction;
    Button2: TButton;
    recSelectionNiveau: TRectangle;
    layBoutonsHaut: TLayout;
    layBoutonsBas: TLayout;
    btnNiveau1: TButton;
    btnNiveau4: TButton;
    btnNiveau3: TButton;
    btnNiveau2: TButton;
    btnNiveau5: TButton;
    btnNiveau9: TButton;
    btnNiveau10: TButton;
    btnNiveau8: TButton;
    btnNiveau7: TButton;
    btnNiveau6: TButton;
    actStatistiques: TAction;
    Button3: TButton;
    recStatistiques: TRectangle;
    btnOK: TButton;
    lstStatistiques: TListBox;
    btnSuivant: TButton;
    layRetour: TLayout;
    btnRetour: TButton;
    layBandeau: TLayout;
    btnReessayer: TButton;
    lmsFond: TLightMaterialSource;
    Label1: TLabel;
    procedure aniPrincipaleProcess(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ObstacleRender(Sender: TObject; Context: TContext3D);
    procedure BonusRender(Sender: TObject; Context: TContext3D);
    procedure raquetteJoueurMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
      RayDir: TVector3D);
    procedure raquetteJoueurMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single; RayPos, RayDir: TVector3D);
    procedure raquetteJoueurMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure FormDestroy(Sender: TObject);
    procedure aniTransitionProcess(Sender: TObject);
    procedure aniTransitionFinish(Sender: TObject);
    procedure actQuitterExecute(Sender: TObject);
    procedure actJouerExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure panneauMessageClick(Sender: TObject);
    procedure affichage3DClick(Sender: TObject);
    procedure aniCouleurContactFinish(Sender: TObject);
    procedure actSelectionnerNiveauExecute(Sender: TObject);
    procedure btnNiveau1Click(Sender: TObject);
    procedure actStatistiquesExecute(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnRetourClick(Sender: TObject);
    procedure btnReessayerClick(Sender: TObject);
  private
    procedure DeplacementBalle;
    function SizeOf3D(const unObjet3D: TControl3D): TPoint3D;
    procedure ChargerNiveau(indiceNiveau : integer);
    procedure initialiserPositionsDepart;
    procedure actionJeu;
    procedure Introduction;
    procedure Menu;
    procedure afficherMessage(texte: string);
    procedure affichageScene;
    procedure afficherCercles;
    procedure lireStatistiques;
    function MettreAJourStatistiques:boolean;
    procedure LancerNiveau(niveau: integer);
    { Déclarations privées }
  public
    { Déclarations publiques }
    jeu : TEtatJeu; // Etat du jeu : permet de choisir la scène à afficher
    niveauJeu : TNiveauJeu; // le niveau jouable
    nbVie, nbViePerdue, nbRebond, numNiveau : integer; // nombre d'essais autorisé
    gagne : boolean;
    nomFichierStat : String;
    Statistiques : TStringlist;
  end;

const
  MaxVie = 5;

var
  fPrincipale: TfPrincipale;

implementation
{$R *.fmx}

// L'utilisateur clique sur le bouton Jouer
procedure TfPrincipale.actJouerExecute(Sender: TObject);
begin
  LancerNiveau(1);
end;

procedure TfPrincipale.LancerNiveau(niveau: integer);
begin
  jeu := ejJeu;                 // On passe l'état du jeu à ejJeu
  nbVie := MaxVie;              // On fixe à 5 le nombre de tentatives
  nbViePerdue := 0;             // Nombre de vies perdues (pour afficher ou non le "parafait" en fin de niveau)
  affichageScene;
  afficherCercles;
  initialiserPositionsDepart;   // Initialisation des positions et orientations pour faire/refaire le niveau
  DissolveTransitionEffect1.Progress := 100;
  numNiveau := niveau;
  nbRebond := 0;
  lRebond.text := IntToStr(nbRebond);
  gagne := false;
  ChargerNiveau(numNiveau); // charge le niveau jouable
  aniPrincipale.stop;
  aniTransition.start;          // Démarre l'animation de transition
end;

// L'utilisateur clique sur le bouton Quitter
procedure TfPrincipale.actQuitterExecute(Sender: TObject);
begin
  close;
end;

procedure TfPrincipale.actSelectionnerNiveauExecute(Sender: TObject);
begin
  layBoutonsHaut.Height := (recSelectionNiveau.Height - layRetour.Height) / 2;

  btnNiveau1.enabled := false; btnNiveau2.enabled := false;
  btnNiveau3.enabled := false; btnNiveau4.enabled := false;
  btnNiveau5.enabled := false; btnNiveau6.enabled := false;
  btnNiveau7.enabled := false; btnNiveau8.enabled := false;
  btnNiveau9.enabled := false; btnNiveau10.enabled := false;

  case Statistiques.count of
    0 : btnNiveau1.enabled := true;
    1 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
        end;
    2 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
        end;
    3 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
        end;
    4 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
          btnNiveau5.enabled := true;
        end;
    5 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
          btnNiveau5.enabled := true;
          btnNiveau6.enabled := true;
        end;
    6 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
          btnNiveau5.enabled := true;
          btnNiveau6.enabled := true;
          btnNiveau7.enabled := true;
        end;
    7 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
          btnNiveau5.enabled := true;
          btnNiveau6.enabled := true;
          btnNiveau7.enabled := true;
          btnNiveau8.enabled := true;
        end;
    8 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
          btnNiveau5.enabled := true;
          btnNiveau6.enabled := true;
          btnNiveau7.enabled := true;
          btnNiveau8.enabled := true;
          btnNiveau9.enabled := true;
        end;
     9, 10 : begin
          btnNiveau1.enabled := true;
          btnNiveau2.enabled := true;
          btnNiveau3.enabled := true;
          btnNiveau4.enabled := true;
          btnNiveau5.enabled := true;
          btnNiveau6.enabled := true;
          btnNiveau7.enabled := true;
          btnNiveau8.enabled := true;
          btnNiveau9.enabled := true;
          btnNiveau10.enabled := true;
        end;
  end;

  recSelectionNiveau.Visible := true;
end;

procedure TfPrincipale.actStatistiquesExecute(Sender: TObject);
var
  i : integer;
begin
  // Affichage des statistiques
  lstStatistiques.Clear;
  for I := 0 to Statistiques.count-1 do
  begin
    lstStatistiques.Items.Add('Niveau '+(i+1).ToString+' : '+Statistiques[i]+' rebonds');
  end;
  recStatistiques.Visible := true;
end;

// Boucle principale du jeu
procedure TfPrincipale.aniCouleurContactFinish(Sender: TObject);
begin
  inc(nbRebond);
  lRebond.text := IntToStr(nbRebond);
end;

procedure TfPrincipale.aniPrincipaleProcess(Sender: TObject);
var
  recordBattu : boolean;
  libelle : string;
begin
  // Rien de compliqué : en fonction de l'état de jeu, on affiche la scène correspondante
  case jeu of
    ejIntro : introduction;
    ejMenu  : menu;
    ejJeu   : actionJeu;
    ejPerdu : afficherMessage('Perdu :(');
    ejGagne : begin
                recordBattu := MettreAJourStatistiques;
                libelle := 'Gagné :)';
                if nbViePerdue = 0 then libelle := libelle+' '+'Parfait !';
                if recordBattu then libelle := libelle +#13+ 'Record !';
                afficherMessage(libelle);
                gagne := true;
                nbRebond := 0;
                nbViePerdue := 0;
                lRebond.text := IntToStr(nbRebond);
                inc(numNiveau);
              end;
    ejFinJeu : afficherMessage('Félicitations !');
  end;
end;

// Mise à jour des stats
function TfPrincipale.MettreAJourStatistiques:boolean;
var
  modifStatistiques : boolean;
begin
  modifStatistiques := false;
  if numNiveau > Statistiques.count then
  begin
    Statistiques.Add(inttostr(nbRebond));
    modifStatistiques := true;
  end
  else
  begin
    if strtointdef(Statistiques[numNiveau-1],0) > nbRebond then
    begin
      Statistiques[numNiveau-1] := IntToStr(nbRebond);
      modifStatistiques := true;
    end;
  end;

  if modifStatistiques then  Statistiques.SaveToFile(nomFichierStat);
  result := modifStatistiques;
end;

// Affichage de la scène "Introduction"
procedure TfPrincipale.Introduction;
begin
  // On affiche que les éléments constituant cette phase
  affichageScene;

  // Au début, on zoome sur le TEXTE 3D "FMX Corridor"
  if lIntro.Scale.x < 2 then
  begin
    lIntro.Scale.x := lIntro.Scale.x + 0.01;
    lIntro.Scale.y := lIntro.Scale.y + 0.01;
    lIntro.Scale.z := lIntro.Scale.z + 0.01;
  end
  else
  begin
    // Puis, on ne zoome plus, on applique une rotation
    lIntro.RotationAngle.x := lIntro.RotationAngle.x +1;
  end;
end;

// Permet de masquer/afficher les éléments en foncton de l'état de jeu
procedure TfPrincipale.affichageScene;
begin
  case jeu of
    ejIntro: begin
               if dmyScene.Visible then
               begin
                 dmyScene.Visible := false;
                 affichage3D.UsingDesignCamera := true;
               end;
               layMenu.Visible := false;
               layMessage.visible := false;
               dmyIntro.Visible := true;
               raquetteJoueur.Visible := false;
               layInfos.Visible := false;
               layIntroMessage.Visible := true;
               lumiereIntro.Visible := true;
               lumiereIntro.Enabled := true;
               lumiereNiveau.Visible := false;
               lumiereNiveau.Enabled := false;
               layRebond.Visible := false;
             end;
    ejJeu:
            begin
              if not(dmyScene.Visible) then
              begin
                dmyScene.Visible := true;
                affichage3D.UsingDesignCamera := false;
              end;
              layMenu.Visible := false;
              layMessage.visible := false;
              dmyIntro.Visible := false;
              raquetteJoueur.Visible := true;
              layInfos.Visible := true;
              layIntroMessage.Visible := false;
              lumiereIntro.Visible := false;
              lumiereIntro.Enabled := false;
              lumiereNiveau.Visible := true;
              lumiereNiveau.Enabled := true;
              layRebond.Visible := true;
              recSelectionNiveau.Visible := false;
            end;
    ejPerdu, ejGagne:
            begin
              layMessage.visible := true;
            end;
    ejMenu: begin
              if dmyScene.Visible then
              begin
                dmyScene.Visible := false;
                affichage3D.UsingDesignCamera := true;
              end;
              layMenu.Visible := true;
              layMessage.visible := false;
              dmyIntro.Visible := true;
              raquetteJoueur.Visible := false;
              layInfos.Visible := false;
              layIntroMessage.Visible := false;
              lumiereIntro.Visible := true;
              lumiereIntro.Enabled := true;
              lumiereNiveau.Visible := false;
              lumiereNiveau.Enabled := false;
              layRebond.Visible := false;
            end;
  end;
end;

// Affichage de la scene "Menu"
procedure TfPrincipale.Menu;
begin
  affichageScene;
  recMenu.position.Y := (affichage3D.Height-recMenu.Height) / 2;
  recMenu.position.X := (affichage3D.width-recMenu.Width) / 2;
  lIntro.Scale.x := 2;
  lIntro.Scale.y := 2;
  lIntro.Scale.z := 2;
  lIntro.RotationAngle.x := lIntro.RotationAngle.x +1;
end;

// Affichage de la scène "ActionJeu" : c'est la scène principale du jeu :)
procedure TfPrincipale.actionJeu;
begin
  affichageScene;

  // Le déplacement est effctué sur l'axe Z et on déplace le dmyJoueur (la caméra lui étant rattachée)
  dmyJoueur.Position.Z := dmyJoueur.Position.Z + niveauJeu.VitesseDefilement;
  // Procédure qui gère le mouvement de la balle
  DeplacementBalle;

  // Si le dmyJoueur atteint la position (sur l'axe Z) défini dans le niveau comme étant la position d'arrivée,
  // alors c'est gagné : on passe le jeu à l'état ejGagne !
  if dmyJoueur.Position.Z > niveauJeu.FinNiveau then jeu := ejGagne;

  // La balle est passée derrière la raquette du joueur : on perd une "vie"...
  if Balle.Position.Z < dmyJoueur.Position.Z -1 then
  begin
    // On décrémente le compteur de vie
    dec(nbVie);
    // On incrémente le nb de vies perdues
    inc(nbViePerdue);
    // Suppression d'un cercle
    afficherCercles;
    // On replace la bille devant la raquette du joueur
    Balle.position.Z := dmyJoueur.Position.Z + 0.1;
    Balle.position.Y := 0;
    Balle.position.X := 0;
    // On redonne à la balle la direction d'origine (définie dans le niveau)
    Balle.Position.DefaultValue := niveauJeu.DirectionBalleDepart;
    aniPrincipale.stop;
    DissolveTransitionEffect1.Progress := 100;
    aniTransition.start;
  end;

  // Si le compteur de vie est à 0, c'est perdu : on passe le jeu à l'état correspondant
  if nbVie = 0 then jeu := ejPerdu;
end;

// Affiche les cercles symbole du nb de tentatives restantes
procedure TfPrincipale.afficherCercles;
begin
  case nbVie of
    0 : begin
          Circle1.Visible := false;
          Circle2.Visible := false;
          Circle3.Visible := false;
          Circle4.Visible := false;
          Circle5.Visible := false;
        end;
    1 : begin
          Circle1.Visible := false;
          Circle2.Visible := false;
          Circle3.Visible := false;
          Circle4.Visible := false;
          Circle5.Visible := true;
        end;
    2 : begin
          Circle1.Visible := false;
          Circle2.Visible := false;
          Circle3.Visible := false;
          Circle4.Visible := true;
          Circle5.Visible := true;
        end;
    3 : begin
          Circle1.Visible := false;
          Circle2.Visible := false;
          Circle3.Visible := true;
          Circle4.Visible := true;
          Circle5.Visible := true;
        end;
    4 : begin
          Circle1.Visible := false;
          Circle2.Visible := true;
          Circle3.Visible := true;
          Circle4.Visible := true;
          Circle5.Visible := true;
        end;
    5 : begin
          Circle1.Visible := true;
          Circle2.Visible := true;
          Circle3.Visible := true;
          Circle4.Visible := true;
          Circle5.Visible := true;
        end;
  end;
end;

// Lorsqu'on clique sur le TViewport3D et qu'on est dans la scène Intro, on affiche la scène Menu
procedure TfPrincipale.affichage3DClick(Sender: TObject);
begin
  if jeu = ejIntro then jeu := ejMenu; // On passe à la scène du menu
end;

// Affiche la scène "Afficher Message" : pour les écrans "gagné" et "perdu"
procedure TfPrincipale.afficherMessage(texte : string);
begin
  affichageScene;
  // On stoppe l'animation principale
  aniPrincipale.StopAtCurrent;
  lMessage.Text := texte;
end;

// Gestion du déplacement de la balle
procedure TfPrincipale.DeplacementBalle;
var
  DirectionBalle, DistanceEntreObjets, distanceMinimum:TPoint3D;
begin
  DirectionBalle:=Balle.Position.DefaultValue;
  DistanceEntreObjets:=zoneJeu.AbsoluteToLocal3D(TPoint3D(Balle.AbsolutePosition));

  distanceMinimum:=(SizeOf3D(zoneJeu) - SizeOf3d(Balle)) / 2;

  if ((DistanceEntreObjets.X > distanceMinimum.X) and (DirectionBalle.X > 0)) or (( DistanceEntreObjets.X < -distanceMinimum.X) and (DirectionBalle.X < 0))  then  DirectionBalle.X := -DirectionBalle.x;
  if ((DistanceEntreObjets.Y > distanceMinimum.Y) and (DirectionBalle.Y > 0)) or (( DistanceEntreObjets.Y < -distanceMinimum.Y) and (DirectionBalle.Y < 0))  then  DirectionBalle.Y := -DirectionBalle.Y ;
  if ((DistanceEntreObjets.Z > distanceMinimum.Z) and (DirectionBalle.Z > 0)) or (( DistanceEntreObjets.Z < -distanceMinimum.Z) and (DirectionBalle.Z < 0))  then  DirectionBalle.Z := -DirectionBalle.Z;

  // Nouvelle position
  Balle.Position.Point := Balle.Position.Point + DirectionBalle.Normalize * niveauJeu.VitesseBalle;
 // Juste pour le fun, on applique arbitrairement des rotations sur les 3 axes de la balle
  balle.RotationAngle.X := balle.RotationAngle.X - 6;
  balle.RotationAngle.Y := balle.RotationAngle.Y + 5;
  balle.RotationAngle.Z := balle.RotationAngle.Z - 6;

  Balle.Position.DefaultValue:=DirectionBalle;
  ombre.Position.X := balle.Position.x;
  ombre.Position.Z := balle.Position.z;
end;

// Initialisation de l'application
procedure TfPrincipale.FormCreate(Sender: TObject);
begin
  jeu := ejIntro; // On force l'état de jeu pour afficher l'introduction au démarrage
  raquetteJoueur.AutoCapture := true; // la raquette du joueur capture la souris sur le OnMouseDown
  niveauJeu := TNiveauJeu.Create; // Création de l'objet qui contiendra le niveau jouable
  nomFichierStat := System.IOUtils.TPath.GetDocumentsPath+System.IOUtils.TPath.DirectorySeparatorChar +'fmxcorridor.txt'; // Nom du fichier des statistiques
  Statistiques := TStringlist.Create;
  lireStatistiques;
end;

// Chargement des statistiques
procedure TfPrincipale.lireStatistiques;
begin
  if FileExists(nomFichierStat) then
  begin
    Statistiques.LoadFromFile(nomFichierStat);
  end;
end;

// On quitte l'application
procedure TfPrincipale.FormDestroy(Sender: TObject);
begin
  niveauJeu.free;
  Statistiques.free;
end;

// A l'affichage de la form, on active l'animation de la boucle principale
procedure TfPrincipale.FormShow(Sender: TObject);
begin
  aniPrincipale.Start;
end;

// Permet de positionner des éléments du jeu aux positions initiales
procedure TfPrincipale.InitialiserPositionsDepart;
begin
  // Initialisation de la balle et du point de vue
  Balle.Position.Point := niveauJeu.PositionBalleDepart; // Position de la balle au début du niveau
  ombre.Position.X := balle.Position.x;
  ombre.Position.Z := balle.Position.z;
  arrivee.Position.Z := niveauJeu.FinNiveau;
  raquetteJoueur.Width := 0.75;
  raquetteJoueur.Height := 0.75;
  Balle.Position.DefaultValue := niveauJeu.DirectionBalleDepart; // Direction de la balle au départ
  lumiereNiveau.LightType := niveauJeu.TypeLumiere; // Type de lumière
//  lumiereNiveau.Color := niveauJeu.CouleurLumiere; // Couleur du niveau
  lmsTunnel.Ambient := niveauJeu.CouleurLumiere;
  lmsTunnel.Emissive := niveauJeu.CouleurLumiere;
  lmsFond.Ambient := niveauJeu.CouleurLumiere;
  lmsFond.Emissive := niveauJeu.CouleurLumiere;
  dmyJoueur.Position.Z := Balle.Position.Z -1; // On place la raquette du joueur (et la caméra) derrière la balle
  depart.Position.Z := dmyJoueur.Position.Z;
  lNomNiveau.Text := niveauJeu.Nom; // Affichage du nom du niveau
end;

// Fin de l'animation de transition : on réactive l'animation principale
procedure TfPrincipale.aniTransitionFinish(Sender: TObject);
begin
  DissolveTransitionEffect1.Enabled := false;
  aniPrincipale.Start;
end;

// Animation de transition qui exécute l'effet "DissolveTransitionEffect"
procedure TfPrincipale.aniTransitionProcess(Sender: TObject);
begin
  DissolveTransitionEffect1.Enabled := true;
  {$IFDEF ANDROID}  // Sur mon téléphone Android 5.0, l'animation est plus lente que sur PC, donc j'enlève 4 à chaque itération sous Android
    DissolveTransitionEffect1.Progress := DissolveTransitionEffect1.Progress - 4;
  {$ELSE}  // Sur PC et Mac, l'animation est suffisamment rapide pour se dérouler entièrement en 2s
    DissolveTransitionEffect1.Progress := DissolveTransitionEffect1.Progress - 1;
  {$ENDIF}
end;

//Chargement d'un niveau
procedure TfPrincipale.ChargerNiveau(indiceNiveau : integer);
var
  i : integer;
  Obstacle, Bonus : TProxyObject;
  animation : TFloatAnimation;
begin
  // On supprime l'éventuel niveau déjà chargé
  for I := zoneJeu.ChildrenCount-1 downto 0 do
  begin
    if not(zoneJeu.Children[i] is TProxyObject) then continue;
    Obstacle:=TProxyObject(zoneJeu.children[i]);
    zoneJeu.RemoveObject(Obstacle);
    FreeAndNil(Obstacle);
  end;

  case indiceNiveau of
    1 : niveauJeu.CreationNiveau; // On créer le niveau (le code est dans uJeu.pas)
    2 : niveauJeu.CreationNiveau2;
    3 : niveauJeu.CreationNiveau3;
    4 : niveauJeu.CreationNiveau4;
    5 : niveauJeu.CreationNiveau5;
    6 : niveauJeu.CreationNiveau6;
    7 : niveauJeu.CreationNiveau7;
    8 : niveauJeu.CreationNiveau8;
    9 : niveauJeu.CreationNiveau9;
    10 : niveauJeu.CreationNiveau10;
  end;
  initialiserPositionsDepart; // Initialisation des positions/orientations des objets

  // Pour chaque Bonus défini dans le niveau, on va instancier un objet FMX 3D correspondant en fonction
  // des informations contenues dans le niveau
  for I := 0 to niveauJeu.fBonusInfo.Count -1 do
  begin
    // On crée des TProxyObject
    Bonus := TProxyObject.Create(zoneJeu);

    case niveauJeu.fBonusInfo[i].fTypeBonus of
      bAgrandir : begin
                    bonus.SourceObject := modeleBonusAgrandir;
                    bonus.tag := 2;
                  end;
      bReduire : begin
                    bonus.SourceObject := modeleBonusReduire;
                    bonus.tag := 3;
                  end;
      bVie : begin
                    bonus.SourceObject := modeleBonusVie;
                    bonus.tag := 4;
                  end;
    end;

    Bonus.Parent := zoneJeu; // L'obstacle aura pour parent la zone de jeu

    // Positionnement et taille de l'obstacle
    Bonus.Position.x := niveauJeu.fBonusInfo[i].X;
    Bonus.Position.y := niveauJeu.fBonusInfo[i].Y;
    Bonus.Position.Z := niveauJeu.fBonusInfo[i].Z;
    Bonus.Height := 0.2;
    Bonus.Width := 0.2;
    Bonus.Depth := 0.2;

    // Affectation de l'événement OnRender (permettra de gérer les interactions avec la balle)
    Bonus.OnRender := BonusRender;
    Bonus.HitTest := false; // pour éviter qu'en cliquant, on sélectionne un bonus (seule la raquette du joueur sera sélectionnable)
  end;

  // Pour chaque Obstacle défini dans le niveau, on va instancier un objet FMX 3D correspondant en fonction
  // des informations contenues dans le niveau
  for I := 0 to niveauJeu.fNiveau.Count -1 do
  begin
    // On crée des TProxyObject
    Obstacle := TProxyObject.Create(zoneJeu);
    Obstacle.SourceObject := modeleObstacle; // en prennant pour modèle celui positionné en conception dans Delphi
    Obstacle.Parent := zoneJeu; // L'obstacle aura pour parent la zone de jeu

    // Positionnement et taille de l'obstacle
    Obstacle.Position.x := niveauJeu.fNiveau[i].X;
    Obstacle.Position.y := niveauJeu.fNiveau[i].Y;
    Obstacle.Position.Z := niveauJeu.fNiveau[i].Z;
    Obstacle.Height := niveauJeu.fNiveau[i].Hauteur;
    Obstacle.Width := niveauJeu.fNiveau[i].Largeur;
    Obstacle.Depth := niveauJeu.fNiveau[i].Profondeur;
    // Affectation de l'événement OnRender (permettra de gérer les interactions avec la balle)
    Obstacle.OnRender := ObstacleRender;
    Obstacle.HitTest := false; // pour éviter qu'en cliquant, on sélectionne un obstacle (seule la raquette du joueur sera sélectionnable)

    // Création des animations pour les obstacles animés
    case niveauJeu.fNiveau[i].Animation of
      aoHorizontal :
         begin
           animation := TFloatAnimation.Create(Obstacle);
           animation.PropertyName := 'Position.X';
           animation.StartValue := Obstacle.Position.X;
           animation.StopValue := niveauJeu.fNiveau[i].FinAnimation;
           animation.Loop := true;
           animation.AutoReverse := true;
           animation.Duration := niveauJeu.fNiveau[i].DureeAnimation;
           animation.Parent := Obstacle;
           animation.Start;
         end;
      aoVertical :
         begin
           animation := TFloatAnimation.Create(Obstacle);
           animation.PropertyName := 'Position.Y';
           animation.StartValue := Obstacle.Position.Y;
           animation.StopValue := niveauJeu.fNiveau[i].FinAnimation;
           animation.Loop := true;
           animation.AutoReverse := true;
           animation.Duration := niveauJeu.fNiveau[i].DureeAnimation;
           animation.Parent := Obstacle;
           animation.Start;
         end;
    end;
  end;
end;

// Quand on clique sur la raquette
procedure TfPrincipale.RaquetteJoueurMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
  RayDir: TVector3D);
begin
  // L'utilisateur clique sur sa raquette, on récupère la position de la raquette
  if ssLeft in Shift then
  begin
     with TControl3d(Sender).Position do DefaultValue:= Point - TPoint3D((RayDir * RayPos.length)) * Point3D(1,0,0);
  end;
end;

// Déplacement de la raquette
procedure TfPrincipale.RaquetteJoueurMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
begin
  {$IFNDEF ANDROID}
    affichage3D.BeginUpdate;
  {$ENDIF}
  // L'utilisateur maintient le bouton gauche de la souris enfoncé et déplace la souris, alors on déplace sa raquette
  if ssLeft in Shift then
  begin
    with TControl3D(sender).Position do
    begin
      // Nouvelle position de la raquette du joueur
      Point := DefaultValue + TPoint3D(RayDir *RayPos.length) * Point3D(1,1,0);
    end;
  end;
  {$IFNDEF ANDROID}
    affichage3D.EndUpdate;
  {$ENDIF}
end;

// On lâche la raquette, on la fait revenir au centre de l'écran
procedure TfPrincipale.RaquetteJoueurMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
  RayDir: TVector3D);
begin
  TAnimator.AnimateFloat(raquetteJoueur,'Position.X',0);
  TAnimator.AnimateFloat(raquetteJoueur,'Position.Y',0);
end;

// OnRender des différents objets obstacles et de la raquette
procedure TfPrincipale.ObstacleRender(Sender: TObject; Context: TContext3D);
var
  unObjet3D:TControl3D; // l'objet en cours de rendu
  DistanceEntreObjets,Direction,distanceMinimum: TPoint3D;
begin
  unObjet3D := TControl3D(sender); // On travail sur l'objet qui est en train d'être calculé
  DistanceEntreObjets := unObjet3D.AbsoluteToLocal3D(TPoint3D(Balle.AbsolutePosition)); // Distance entre l'objet 3d et la balle
  distanceMinimum := (SizeOf3D(unObjet3D) + SizeOf3D(Balle)) / 2; // distanceMinimum : on divise par 2 car le centre de l'objet est la moitié de la taille de l'élément sur les 3 composantes X, Y, Z

  // Test si la valeur absolue de position est inférieure à la distanceMinimum calculée sur chacune des composantes
  if ((Abs(DistanceEntreObjets.X) < distanceMinimum.X) and (Abs(DistanceEntreObjets.Y) < distanceMinimum.Y) and
      (Abs(DistanceEntreObjets.Z) < distanceMinimum.Z)) then
  begin
    // Si c'est le cas, c'est qu'il y a collision
    Direction := Balle.Position.Point - unObjet3D.Position.Point; // On calcule la nouvelle direction de la balle
    Balle.Position.DefaultValue := Direction; // On affecte la nouvelle direction
    if unObjet3D.tag = 1 then
    begin
      aniCouleurContact.Start; // petit plus si la propriété tag de l'objet est 1 (seule la raquette du joueur a le tag à 1), alors on lance l'animation de couleur pour faire clignoter en vert la raquette
    end;
  end;
end;

// OnRender des bonus
procedure TfPrincipale.BonusRender(Sender: TObject; Context: TContext3D);
var
  unObjet3D:TControl3D; // l'objet en cours de rendu
  DistanceEntreObjets,distanceMinimum: TPoint3D;
begin
  unObjet3D := TControl3D(sender); // On travail sur l'objet qui est en train d'être calculé
  unObjet3D.RotationAngle.Z := unObjet3D.RotationAngle.Z + 3;
  unObjet3D.RotationAngle.X := unObjet3D.RotationAngle.X + 4;
  unObjet3D.RotationAngle.Y := unObjet3D.RotationAngle.Y -3;

  DistanceEntreObjets := unObjet3D.AbsoluteToLocal3D(TPoint3D(Balle.AbsolutePosition)); // Distance entre l'objet 3d et la balle
  distanceMinimum := (SizeOf3D(unObjet3D) + SizeOf3D(Balle)) / 2; // distanceMinimum : on divise par 2 car le centre de l'objet est la moitié de la taille de l'élément sur les 3 composantes X, Y, Z

  // Test si la valeur absolue de position est inférieure à la distanceMinimum calculée sur chacune des composantes
  if ((Abs(DistanceEntreObjets.X) < distanceMinimum.X) and (Abs(DistanceEntreObjets.Y) < distanceMinimum.Y) and
      (Abs(DistanceEntreObjets.Z) < distanceMinimum.Z)) then
  begin
    case unObjet3D.Tag of
      2 : begin
            raquetteJoueur.Width := raquetteJoueur.Width * 2;
            raquetteJoueur.Height := raquetteJoueur.Height * 2;
            unObjet3D.tag := 0;
            unObjet3D.Visible := false;
          end;
      3 : begin
            raquetteJoueur.Width := raquetteJoueur.Width / 2;
            raquetteJoueur.Height := raquetteJoueur.Height / 2;
            unObjet3D.tag := 0;
            unObjet3D.Visible := false;
          end;
      4 : begin
            if nbVie < MaxVie then
            begin
               inc(nbvie);
               afficherCercles;
            end;
            unObjet3D.tag := 0;
            unObjet3D.Visible := false;
          end;
    end;
  end;
end;

procedure TfPrincipale.btnNiveau1Click(Sender: TObject);
begin
  LancerNiveau((sender as TButton).tag);
end;

procedure TfPrincipale.btnOKClick(Sender: TObject);
begin
  recStatistiques.Visible := false;
end;

procedure TfPrincipale.btnReessayerClick(Sender: TObject);
begin
  if gagne then
  begin
    dec(numNiveau);
    gagne := false;
  end
  else nbVie := MaxVie;              // On fixe à 5 le nombre de tentatives
  jeu := ejJeu;
  ChargerNiveau(numNiveau);
  nbViePerdue := 0;             // Nombre de vies perdues (pour afficher ou non le "parafait" en fin de niveau)
  affichageScene;
  afficherCercles;
  nbRebond := 0;
  lRebond.text := IntToStr(nbRebond);
  initialiserPositionsDepart;   // Initialisation des positions et orientations pour faire/refaire le niveau
  aniPrincipale.Start; // Relance de l'animation principale
end;

procedure TfPrincipale.btnRetourClick(Sender: TObject);
begin
  recSelectionNiveau.Visible := false;
end;

// L'utilisateur clique sur le panneau d'information (scène "Gagné" ou "Perdu")
procedure TfPrincipale.panneauMessageClick(Sender: TObject);
begin
  if gagne and (numNiveau <= niveauJeu.NbNiveau) then
  begin
    jeu := ejJeu;
    gagne := false;
    ChargerNiveau(numNiveau);
  end
  else
  begin
    if gagne and (numNiveau > niveauJeu.NbNiveau) then
    begin
      jeu := ejFinJeu;
      gagne := false;
    end
    else jeu := ejMenu; // On souhaite retourner au menu
  end;
  aniPrincipale.Start; // Relance de l'animation principale
end;

// Renvoi les dimensions de l'objet 3D
function TfPrincipale.SizeOf3D(const unObjet3D: TControl3D): TPoint3D;
begin
  Result :=NullPoint3D;
  if unObjet3D <> nil then
    result := Point3D(unObjet3D.Width, unObjet3D.Height, unObjet3D.Depth);
end;

end.
