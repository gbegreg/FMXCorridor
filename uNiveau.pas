unit uNiveau;

interface

uses Generics.Collections, System.Math.Vectors, System.UITypes, FMX.Types3d;

type
  TEtatJeu = (ejIntro, ejJeu, ejPerdu, ejGagne, ejMenu, ejFinJeu); // Les états du jeu
  TBonus = (bAgrandir, bReduire, bVie); // Les types de bonus possibles
  TAnimationObstacle = (aoAucune, aoHorizontal, aoVertical); // Animations possible pour les obstacles

  // Informations sur un obstacle
  TObstacle = class
      fX, fY, fZ, fFinAnimation : single; // Position
      fLargeur, fHauteur, fProfondeur, fDureeAnimation : single; // Taille
      fAnimation : TAnimationObstacle; // Animation de l'obstacle

    public
      constructor Create; virtual;
      property X : single read fX write fX;
      property Y : single read fY write fY;
      property Z : single read fZ write fZ;
      property Largeur : single read fLargeur write fLargeur;
      property Hauteur : single read fHauteur write fHauteur;
      property Profondeur : single read fProfondeur write fProfondeur;
      property Animation : TAnimationObstacle read fAnimation write fAnimation;
      property DureeAnimation : single read fDureeAnimation write fDureeAnimation;
      property FinAnimation : single read fFinAnimation write fFinAnimation;
  end;

  // Informations sur un bonus
  TBonusInfo = class
      fX, fY, fZ, fFinAnimation : single; // Position
      fTypeBonus : TBonus;
    public
      constructor Create; virtual;
      property X : single read fX write fX;
      property Y : single read fY write fY;
      property Z : single read fZ write fZ;
      property TypeBonus : TBonus read fTypeBonus write fTypeBonus;
  end;

  TObstacleList = TList<TObstacle>;
  TBonusList = TList<TBonusInfo>;

  // Un niveau de jeu
  TNiveauJeu = class
    fNom : string;
    fTaille, fFinNiveau : single;
    fVitesseDefilement, fVitesseBalle : single;
    FPositionBalleDepart : TPoint3D;
    FDirectionBalleDepart : TPoint3D;
    FNbNiveau : integer;
    FCouleurLimere : cardinal;
    FLumiereType : TLightType;

    public
      fNiveau : TObstacleList;
      fBonusInfo : TBonusList;
      constructor Create; virtual;
      destructor Destroy; override;
      procedure CreationNiveau;
      procedure CreationNiveau2;
      procedure CreationNiveau3;
      procedure CreationNiveau4;
      procedure CreationNiveau5;
      procedure CreationNiveau6;
      procedure CreationNiveau7;
      procedure CreationNiveau8;
      procedure CreationNiveau9;
      procedure CreationNiveau10;
      procedure InitialiserNiveau;
      property Nom : String read fNom write fNom;
      property Taille : Single read fTaille write fTaille;
      property FinNiveau : single read fFinNiveau write fFinNiveau;
      property VitesseDefilement : Single read fVitesseDefilement write fVitesseDefilement;
      property VitesseBalle : Single read fVitesseBalle write fVitesseBalle;
      property PositionBalleDepart : TPoint3D read FPositionBalleDepart write FPositionBalleDepart;
      property DirectionBalleDepart : TPoint3D read FDirectionBalleDepart write FDirectionBalleDepart;
      property NbNiveau : integer read FNbNiveau write FNbNiveau;
      property CouleurLumiere : cardinal read FCouleurLimere write FCouleurLimere;
      property TypeLumiere : TLightType read FLumiereType write FLumiereType;
  end;

implementation

{ TObstacle }
constructor TObstacle.Create;
begin
  Animation := aoAucune;
end;

{ TTunnelJeu }
constructor TNiveauJeu.Create;
begin
  fNiveau := TObstacleList.Create;
  fBonusInfo := TBonusList.Create;
  FNbNiveau := 10;
end;

procedure TNiveauJeu.InitialiserNiveau;
var
  i : Integer;
begin
  for I := fNiveau.Count-1 downto 0 do
  begin
    fNiveau.Delete(i);
  end;
  for I := fBonusInfo.Count-1 downto 0 do
  begin
    fBonusInfo.Delete(i);
  end;
end;

procedure TNiveauJeu.CreationNiveau;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.12;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.05;
  {$ENDIF}

  fNom := '1 - Echauffement...';
  FCouleurLimere := TAlphaColors.white;
  FLumiereType := TLightType.Directional;

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 7;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  bonus := TBonusInfo.Create;
  bonus.X := -1;
  bonus.Y := 0.5;
  bonus.Z := 32;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0.5;
  bonus.Z := 25;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 14;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 14;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 18;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 23;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.4;
  obstacle.Y := 0;
  obstacle.Z := 28;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 2;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 35;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 40;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 0.75;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0;
  obstacle.Z := 40;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 0.75;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.4;
  obstacle.Y := 0;
  obstacle.Z := 44;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1.4;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau2;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.08;
    fVitesseBalle := 0.12;
  {$ELSE}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.06;
  {$ENDIF}

  fNom := '2 - Accélération';
  FCouleurLimere := TAlphaColors.Coral;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0.5;
  bonus.Z := 6;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0;
  bonus.Z := 23;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 8;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 14;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 20;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 26;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 32;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 38;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 44;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau3;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.12;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.06;
  {$ENDIF}

  fNom := '3 - On continue...';
  FCouleurLimere := TAlphaColors.Tomato;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0.5;
  bonus.Z := 34;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := -0.2;
  bonus.Y := 0;
  bonus.Z := 7;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := -1;
  bonus.Y := 0.5;
  bonus.Z := 23;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0.2;
  bonus.Y := 0;
  bonus.Z := 5;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.75;
  obstacle.Z := 6;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.DureeAnimation := 0.9;
  obstacle.FinAnimation := 0.75;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0.5;
  obstacle.Z := 11;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0.5;
  obstacle.Z := 12;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := -0.5;
  obstacle.Z := 13;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := -0.5;
  obstacle.Z := 14;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.4;
  obstacle.Y := 0;
  obstacle.Z := 18;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.75;
  obstacle.Z := 21;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.DureeAnimation := 1.5;
  obstacle.FinAnimation := -0.75;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 25;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := 0;
  obstacle.Z := 25.4;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 29;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0;
  obstacle.Z := 29.4;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.75;
  obstacle.Z := 35;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.75;
  obstacle.Z := 35;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 40;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 0.75;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0;
  obstacle.Z := 40;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 0.75;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 43;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 46;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau4;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.16;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.08;
  {$ENDIF}

  fNom := '4 - Ça se complique !';
  FCouleurLimere := TAlphaColors.Crimson;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := -1;
  bonus.Y := 0;
  bonus.Z := 22;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0;
  bonus.Z := 22;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 22;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 7;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.75;
  obstacle.Z := 13;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.75;
  obstacle.Z := 13;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 16;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 16;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 19;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.75;
  obstacle.Z := 22;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.75;
  obstacle.Z := 22;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.4;
  obstacle.Y := 0;
  obstacle.Z := 25;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 1.5;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -2;
  obstacle.Z := 30;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 0.75;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 2;
  obstacle.Z := 30;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 0.75;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 32;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 1.5;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0;
  obstacle.Z := 32;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.DureeAnimation := 1.5;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.75;
  obstacle.Z := 39;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 10;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.75;
  obstacle.Z := 39;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 10;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -2;
  obstacle.Y := 0;
  obstacle.Z := 37;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.DureeAnimation := 3;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 2;
  obstacle.Y := 0;
  obstacle.Z := 39;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.DureeAnimation := 1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 2;
  obstacle.Y := 0;
  obstacle.Z := 41;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.DureeAnimation := 3;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -2;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau5;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.12;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.06;
  {$ENDIF}

  fNom := '5 - Ça va toujours ?';
  FCouleurLimere := TAlphaColors.Darkolivegreen;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := -0.5;
  bonus.Y := 0;
  bonus.Z := 10;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 28;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0.5;
  bonus.Z := 35;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 7;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 12;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 12;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := 0.5;
  obstacle.Z := 17;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 1;

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := -0.5;
  obstacle.Z := 17;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 21;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 25;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0.5;
  obstacle.Z := 30;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := -0.5;
  obstacle.Z := 30;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 1;

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -2;
  obstacle.Z := 36;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 2;

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 36;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 2;

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 40;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 2;

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 44;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 2;
end;

procedure TNiveauJeu.CreationNiveau6;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.12;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.06;
  {$ENDIF}

  fNom := '6 - La découpe';
  FCouleurLimere := TAlphaColors.Maroon;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 7;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 28;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := -1;
  bonus.Y := 0.5;
  bonus.Z := 19.5;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 8;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := -0.7;
  obstacle.Z := 8;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0.7;
  obstacle.Z := 8;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0;
  obstacle.Z := 12;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := -0.7;
  obstacle.Z := 12;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0.7;
  obstacle.Z := 12;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -3;
  obstacle.Z := 18;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.7;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 3;
  obstacle.Z := 21;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.7;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0;
  obstacle.Z := 25;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 30;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 1;
  fNiveau.add(obstacle);
  obstacle.DureeAnimation := 1;

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0;
  obstacle.Z := 31;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 1;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -0.5;
  obstacle.Y := 0;
  obstacle.Z := 32;
  obstacle.Largeur := 3;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 1;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := -0.7;
  obstacle.Z := 38;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 4;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -5;
  obstacle.Y := 0;
  obstacle.Z := 39;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 5;
  obstacle.DureeAnimation := 1.1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -6;
  obstacle.Y := 0.7;
  obstacle.Z := 40;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 6;
  obstacle.DureeAnimation := 1.2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := -0.7;
  obstacle.Z := 41;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 4;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -5;
  obstacle.Y := 0;
  obstacle.Z := 42;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 5;
  obstacle.DureeAnimation := 1.1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -6;
  obstacle.Y := 0.7;
  obstacle.Z := 43;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 6;
  obstacle.DureeAnimation := 1.2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -5;
  obstacle.Y := 0;
  obstacle.Z := 44;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 5;
  obstacle.DureeAnimation := 2;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau7;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.10;
    fVitesseBalle := 0.18;
  {$ELSE}
    fVitesseDefilement := 0.05;
    fVitesseBalle := 0.09;
  {$ENDIF}

  fNom := '7 - C''est du brutal !';
  FCouleurLimere := TAlphaColors.Brown;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 7;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 32;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := -0.5;
  bonus.Z := 26;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 8;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 11;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 14;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 20;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 26;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 32;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 38;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau8;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.10;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.05;
  {$ENDIF}

  fNom := '8 - Courage';
  FCouleurLimere := TAlphaColors.Darkslategray;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 7;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := -1;
  bonus.Y := 0;
  bonus.Z := 16;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0;
  bonus.Z := 23;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0;
  bonus.Z := 31;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0;
  obstacle.Z := 5;
  obstacle.Largeur := 3;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -3;
  obstacle.DureeAnimation := 0.9;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := 0;
  obstacle.Z := 8;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 2;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);


  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 12;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := -3;
  obstacle.DureeAnimation := 2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 17;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := -3;
  obstacle.DureeAnimation := 2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 1.5;
  obstacle.Z := 21;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 0.7;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -1.5;
  obstacle.Z := 21;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 0.7;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0.5;
  obstacle.Z := 25;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 4;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := -0.5;
  obstacle.Z := 25;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -4;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0.5;
  obstacle.Z := 28;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 4;
  obstacle.DureeAnimation := 1.5;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := -0.5;
  obstacle.Z := 28;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := -4;
  obstacle.DureeAnimation := 1.5;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0.5;
  obstacle.Z := 33;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := -0.5;
  obstacle.Z := 33;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 37;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 40;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 43;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 3;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau9;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.06;
    fVitesseBalle := 0.12;
  {$ELSE}
    fVitesseDefilement := 0.03;
    fVitesseBalle := 0.06;
  {$ENDIF}

  fNom := '9 - Nocturne';
  FCouleurLimere := TAlphaColors.Black;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := -0.2;
  bonus.Y := 0;
  bonus.Z := 4;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 1;
  bonus.Y := 0;
  bonus.Z := 16;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := -0.7;
  obstacle.Z := 5;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 4;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -5;
  obstacle.Y := 0;
  obstacle.Z := 6.3;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 5;
  obstacle.DureeAnimation := 1.1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -6;
  obstacle.Y := 0.7;
  obstacle.Z := 7.6;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 6;
  obstacle.DureeAnimation := 1.2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := -0.7;
  obstacle.Z := 8.9;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 4;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -5;
  obstacle.Y := 0;
  obstacle.Z := 10.3;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 5;
  obstacle.DureeAnimation := 1.1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -6;
  obstacle.Y := 0.7;
  obstacle.Z := 11.8;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 6;
  obstacle.DureeAnimation := 1.2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -5;
  obstacle.Y := 0;
  obstacle.Z := 13;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 5;
  obstacle.DureeAnimation := 2;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 1.5;
  obstacle.Z := 20;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 0.7;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -1.5;
  obstacle.Z := 20;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 0.7;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0.5;
  obstacle.Z := 25;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := -0.5;
  obstacle.Z := 25;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 29;
  obstacle.Largeur := 1.5;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 29;
  obstacle.Largeur := 1.5;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0;
  obstacle.Z := 33;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.75;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -2;
  obstacle.Y := 0;
  obstacle.Z := 36;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 2;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.7;
  obstacle.Z := 39;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.7;
  obstacle.Z := 39;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -0.5;
  obstacle.Y := 0;
  obstacle.Z := 43;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 2;
  obstacle.DureeAnimation := 0.5;
  fNiveau.add(obstacle);
end;

procedure TNiveauJeu.CreationNiveau10;
var
  obstacle  : TObstacle;
  bonus : TBonusInfo;
begin
  InitialiserNiveau;

  FDirectionBalleDepart := Point3d(0,0,1);
  FPositionBalleDepart := Point3D(0,0,1);
  FinNiveau := 47;
  {$IFDEF ANDROID}
    fVitesseDefilement := 0.04;
    fVitesseBalle := 0.10;
  {$ELSE}
    fVitesseDefilement := 0.02;
    fVitesseBalle := 0.05;
  {$ENDIF}

  fNom := '10 - Final';
  FCouleurLimere := TAlphaColors.Tomato;
  FLumiereType := TLightType.Directional;

  bonus := TBonusInfo.Create;
  bonus.X := -0.2;
  bonus.Y := 0;
  bonus.Z := 19;
  bonus.TypeBonus := bVie;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := 0;
  bonus.Y := 0;
  bonus.Z := 12;
  bonus.TypeBonus := bAgrandir;
  fBonusInfo.add(bonus);

  bonus := TBonusInfo.Create;
  bonus.X := -1;
  bonus.Y := 0;
  bonus.Z := 27;
  bonus.TypeBonus := bReduire;
  fBonusInfo.add(bonus);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.7;
  obstacle.Z := 6;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.7;
  obstacle.Z := 6;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.7;
  obstacle.Z := 6;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0;
  obstacle.Z := 10;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.70;
  obstacle.Z := 10;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.6;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 10;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.70;
  obstacle.Z := 10;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.6;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoAucune;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 0.4;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0;
  obstacle.Z := 14;
  obstacle.Largeur := 1;
  obstacle.Hauteur := 2;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 1.5;
  obstacle.DureeAnimation := 0.8;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1;
  obstacle.Y := 0.5;
  obstacle.Z := 18;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1;
  obstacle.Y := -0.5;
  obstacle.Z := 18;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.5;
  obstacle.Z := 23;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := -0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.5;
  obstacle.Z := 26;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.2;
  obstacle.fAnimation := aoVertical;
  obstacle.FinAnimation := 0.5;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := 0.5;
  obstacle.Z := 30;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := 0.5;
  obstacle.Z := 31;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -1.5;
  obstacle.Y := -0.5;
  obstacle.Z := 32;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 1.5;
  obstacle.Y := -0.5;
  obstacle.Z := 33;
  obstacle.Largeur := 2;
  obstacle.Hauteur := 1;
  obstacle.Profondeur := 0.1;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0;
  obstacle.Z := 36;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := -0.7;
  obstacle.Z := 36;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0.7;
  obstacle.Z := 36;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 4;
  obstacle.Y := 0;
  obstacle.Z := 40;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := -0.7;
  obstacle.Z := 40;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := -4;
  obstacle.Y := 0.7;
  obstacle.Z := 40;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.7;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoHorizontal;
  obstacle.FinAnimation := 0;
  obstacle.DureeAnimation := 1;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := -0.75;
  obstacle.Z := 43;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.DureeAnimation := 0.6;
  obstacle.FinAnimation := 0.75;
  fNiveau.add(obstacle);

  obstacle := TObstacle.Create;
  obstacle.X := 0;
  obstacle.Y := 0.75;
  obstacle.Z := 45;
  obstacle.Largeur := 4;
  obstacle.Hauteur := 0.5;
  obstacle.Profondeur := 0.4;
  obstacle.fAnimation := aoVertical;
  obstacle.DureeAnimation := 0.6;
  obstacle.FinAnimation := -0.75;
  fNiveau.add(obstacle);
end;

destructor TNiveauJeu.Destroy;
begin
  fNiveau.Free;
  fBonusInfo.Free;
  inherited;
end;

{ TBonusInfo }
constructor TBonusInfo.Create;
begin
  //
end;

end.
