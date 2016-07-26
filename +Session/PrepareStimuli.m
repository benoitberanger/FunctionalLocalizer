%% Horizontal_Checkerboard

Stimuli.Horizontal_Checkerboard = [Stimuli.Image.checherboardHpb Stimuli.Image.checherboardHnb];


%% Vertical_Checkerboard

Stimuli.Vertical_Checkerboard = [Stimuli.Image.checherboardVpb Stimuli.Image.checherboardVnb];


%% Right_Audio_Click

Stimuli.Right_Audio_Click = Stimuli.Audio.clic3D;


%% Left_Audio_Click

Stimuli.Left_Audio_Click = Stimuli.Audio.clic3G;


%% Right_Video_Click

Stimuli.Right_Video_Click = {'appuyez' 'trois fois' 'sur le bouton' 'droit'};


%% Left_Video_Click

Stimuli.Left_Video_Click = {'appuyez' 'trois fois' 'sur le bouton' 'gauche'};


%% Audio_Computation

Stimuli.Audio_Computation = {
    Stimuli.Audio.calc5
    Stimuli.Audio.calc1
    Stimuli.Audio.calc4
    Stimuli.Audio.calc6
    Stimuli.Audio.calc10
    Stimuli.Audio.calc2
    Stimuli.Audio.calc8
    Stimuli.Audio.calc9
    Stimuli.Audio.calc3
    Stimuli.Audio.calc7
    };


%% Video_Computation

Stimuli.Video_Computation = {
    'calculez'	'seize' 	'moins'	'huit'
    'calculez'	'dix'       'moins'	'deux'
    'calculez'	'onze'      'moins'	'neuf'
    'calculez'	'douze' 	'moins'	'quatre'
    'calculez'	'dix-neuf'	'moins'	'six'
    'calculez'	'seize'     'moins'	'deux'
    'calculez'	'treize'	'moins'	'sept'
    'calculez'	'dix-neuf'	'moins'	'sept'
    'calculez'	'onze'      'moins'	'trois'
    'calculez'	'dix-sept'	'moins'	'six'
    };


%% Video_Sentences

Stimuli.Video_Sentences = {
    'l''orage'      'a effrayé' 	'les animaux'	'du zoo'
    'les chats'     'guettent'      'un oiseau'     'sur le mur'
    'le donjon'     'du château'	'tombe'         'en ruine'
    'du balcon'     'on a vu'       'le passage'	'du défilé'
    'les ours'      'adorent'       'le saumon'     'et le miel'
    'en ville'      'on trouve'     'facilement'	'des taxis'
    'le froid'      'de l''hiver'	'a gelé'        'le lac'
    'il y a'        'beaucoup'      'de ponts'      'à Paris'
    'la pluie'      'a rendu'       'la route'      'dangereuse'
    'Les roses'     'sont belles'	'mais elles'	'piquent'
    };

%% Audio_Sentences

Stimuli.Audio_Sentences = {
    Stimuli.Audio.ph1
    Stimuli.Audio.ph2
    Stimuli.Audio.ph3
    Stimuli.Audio.ph4
    Stimuli.Audio.ph5
    Stimuli.Audio.ph6
    Stimuli.Audio.ph7
    Stimuli.Audio.ph8
    Stimuli.Audio.ph9
    Stimuli.Audio.ph10
    };


%% Audio_Sinwave

Audio_Sinwave = [
    8	2	12	1	9	12
    13	9	12	3	1	9
    1	12	13	10	2	10
    3	10	13	11	8	8
    1	13	10	12	3	1
    2	13	10	12	9	2
    10	8	3	11	2	11
    1	9	12	13	3	9
    2	10	13	11	3	13
    10	11	2	13	3	3
    ];

Stimuli.Audio_Sinwave = cell(size(Audio_Sinwave));
for i = 1 : size(Audio_Sinwave,1)
    for j = 1 : size(Audio_Sinwave,2)
        Stimuli.Audio_Sinwav{i,j} = Stimuli.Audio.(sprintf( 'sine%d' , Audio_Sinwave(i,j) ));
    end
end

