% Chamber of Reflection, Mac Demarco

% Initialize sampling frequency
fs = 44100;

% Initialize bpm
bpm = 131;

% Create array of note frequencies
note = zeros(1,12);
for i = 0:11
    note(i+1) = 440*(2^(i/12));
end
A = note(1); Asharp = note(2); B = note(3); C = note(4);
Csharp = note(5); D = note(6); Dsharp = note(7); E = note(8);
F = note(9); Fsharp = note(10); G = note(11); Gsharp = note(12);

% Create octaves - scale each pitch class by octave
A_octaves = A * 2.^(-3:2); 
A1 = A_octaves(1); A2 = A_octaves(2); A3 = A_octaves(3);
A4 = A_octaves(4); A5 = A_octaves(5); A6 = A_octaves(6);

B_octaves = B * 2.^(-3:2);  
B1 = B_octaves(1); B2 = B_octaves(2); B3 = B_octaves(3); 
B4 = B_octaves(4); B5 = B_octaves(5); B6 = B_octaves(6);

C_octaves = C * 2.^(-4:1);  
C1 = C_octaves(1); C2 = C_octaves(2); C3 = C_octaves(3);
C4 = C_octaves(4); C5 = C_octaves(5); C6 = C_octaves(6);

D_octaves = D * 2.^(-4:1);  
D1 = D_octaves(1); D2 = D_octaves(2); D3 = D_octaves(3);
D4 = D_octaves(4); D5 = D_octaves(5); D6 = D_octaves(6);

E_octaves = E * 2.^(-4:1);  
E1 = E_octaves(1); E2 = E_octaves(2); E3 = E_octaves(3);
E4 = E_octaves(4); E5 = E_octaves(5); E6 = E_octaves(6);

F_octaves = F * 2.^(-4:1);  
F1 = F_octaves(1); F2 = F_octaves(2); F3 = F_octaves(3);
F4 = F_octaves(4); F5 = F_octaves(5); F6 = F_octaves(6);

G_octaves = G * 2.^(-4:1);  
G1 = G_octaves(1); G2 = G_octaves(2); G3 = G_octaves(3); 
G4 = G_octaves(4); G5 = G_octaves(5); G6 = G_octaves(6);

% Create flat notes
% Flats matched with their equivalent sharps (ex: Ab = G#)
A_flats = Gsharp * 2.^(-4:1);
Ab1 = A_flats(1); Ab2 = A_flats(2); Ab3 = A_flats(3);
Ab4 = A_flats(4); Ab5 = A_flats(5); Ab6 = A_flats(6);

B_flats = Asharp * 2.^(-3:2);
Bb1 = B_flats(1); Bb2 = B_flats(2); Bb3 = B_flats(3);
Bb4 = B_flats(4); Bb5 = B_flats(5); Bb6 = B_flats(6);

% Cb and B are same pitch so no conversion is necessary
% Cb1 = B0; 
Cb2 = B1; Cb3 = B2; Cb4 = B3; Cb5 = B4; Cb6 = B5;

D_flats = Csharp * 2.^(-4:1);
Db1 = D_flats(1); Db2 = D_flats(2); Db3 = D_flats(3);
Db4 = D_flats(4); Db5 = D_flats(5); Db6 = D_flats(6);

E_flats = Dsharp * 2.^(-4:1);
Eb1 = E_flats(1); Eb2 = E_flats(2); Eb3 = E_flats(3);
Eb4 = E_flats(4); Eb5 = E_flats(5); Eb6 = E_flats(6);

% Fb and E are same pitch so no conversion is necessary
Fb1 = E1; Fb2 = E2; Fb3 = E3; Fb4 = E4; Fb5 = E5; Fb6 = E6;

G_flats = Fsharp * 2.^(-4:1);
Gb1 = G_flats(1); Gb2 = G_flats(2); Gb3 = G_flats(3);
Gb4 = G_flats(4); Gb5 = G_flats(5); Gb6 = G_flats(6);

% Create duration of each note
sixteenth_dur = 0.25*(60/bpm);
eigth_dur = 0.5*(60/bpm);
quarter_dur = (60/bpm);
dotted_quarter_dur = 1.5*(60/bpm);
half_dur = 2*(60/bpm);
dotted_half_dur = 1.5*2*(60/bpm);
whole_dur = 4*(60/bpm);

% Create time vectors
sixteenth = 0:1/fs:sixteenth_dur-1/fs; % [start:increment:end]
eigth = 0:1/fs:eigth_dur-1/fs; 
% tied together eigth and quarter note
tied_e_q = 0:1/fs:(eigth_dur + quarter_dur)-1/fs; 
% tied together eigth and dotted quarter note
tied_e_dq = 0:1/fs:(eigth_dur + dotted_quarter_dur)-1/fs; 
% tied together eigth and half note
tied_e_h = 0:1/fs:(eigth_dur + half_dur)-1/fs;
% tied together eigth and whole note
tied_e_w = 0:1/fs:(eigth_dur + whole_dur)-1/fs; 
% tied together eigth and whole note and whole note
tied_e_w_w = 0:1/fs:(eigth_dur + whole_dur + whole_dur)-1/fs; 
quarter = 0:1/fs:quarter_dur-1/fs; 
dotted_quarter = 0:1/fs:dotted_quarter_dur-1/fs; 
half = 0:1/fs:half_dur-1/fs;
dotted_half = 0:1/fs:dotted_half_dur-1/fs;
whole = 0:1/fs:whole_dur-1/fs;
% tied together half and whole note
tied_w_h = 0:1/fs:(half_dur + whole_dur)-1/fs; 

% Create Exponential Decay Volume Constant
T = 0.45; %

% Treble portion - Phases 1, 2, 1, 2 
treble_song = [];
for r = 1:2
    time_array = {half, quarter, quarter, dotted_quarter, sixteenth, sixteenth, half, half, quarter, quarter, dotted_quarter, eigth, half, dotted_quarter, sixteenth, sixteenth, half, dotted_half, eigth, eigth, eigth, eigth, dotted_half, whole};
    keys = [0 Gb5 Eb5 Bb4 Cb5 Bb4 Ab4 0 Bb4 Cb5 Db5 Bb4 F4 F4 Gb4 F4 Eb4 0 0 Db4 Eb4 Bb3 0 0];
    for i = 1:length(keys)
        t1 = time_array{i};
        A_t = (exp(-t1/T)); % exponential decay function
        if keys(i) == 0
            y = zeros(size(time_array{i}));
        else
            y = (1/1)*A_t.*cos(2 * pi * keys(i) * time_array{i});
        end
    treble_song = [treble_song, y];
    end
end

% Treble Portion - Phases 3 & 4 
time_array = {half, quarter, quarter, quarter, eigth, tied_e_h, half, eigth, quarter, tied_e_q, eigth, eigth, quarter, eigth, tied_e_q, eigth, tied_e_q, eigth, tied_e_w, whole, whole};
keys = [0 Gb5 Eb5 Bb4 Cb5 Ab4 0 Bb4 Cb5 Db5 Bb4 F4 0 Db4 Eb4 Bb4 Bb4 Ab4 Bb4 0 0];
for i = 1:length(keys)
    t1 = time_array{i};
    A_t = (exp(-t1/T)); % exponential decay function
    if keys(i) == 0
        y = zeros(size(time_array{i}));
    else
       y = (1/1)*A_t.*cos(2 * pi * keys(i) * time_array{i}); % fundamental
       y = y + (1/2)*A_t.*cos(2 * pi * (2*keys(i)) * time_array{i}); % 2nd harmonic
    end
    treble_song = [treble_song, y];
end

% Treble Portion - Phases 5 & 6
time_array = {half, quarter, quarter, quarter, eigth, tied_e_h, half, eigth, quarter, tied_e_q, eigth, eigth, quarter, eigth, tied_e_q, eigth, eigth, eigth, dotted_quarter, dotted_half, eigth, tied_e_h, half, dotted_half, eigth, tied_e_dq};
keys = [0 Gb5 Eb5 Bb4 Cb5 Ab4 0 Bb4 Cb5 Db5 Bb4 F4 0 Db4 Eb4 Bb4 Bb4 Ab4 Bb4 0 Db4 Eb4 0 0 Db4 Eb4];
for i = 1:length(keys)
    t1 = time_array{i};
    A_t = (exp(-t1/T)); % exponential decay function
    if keys(i) == 0
        y = zeros(size(time_array{i}));
    else
       y = (1/1)*A_t.*cos(2 * pi * keys(i) * time_array{i}); % fundamental
       y = y + (1/2)*A_t.*cos(2 * pi * (2*keys(i)) * time_array{i}); % 2nd harmonic
       y = y + (1/3)*A_t.*cos(2 * pi * (3*keys(i)) * time_array{i}); % 3rd harmonic
    end
    treble_song = [treble_song, y];
end

% Treble Portion - Phases 7 & 8
time_array = {quarter, dotted_quarter, dotted_half, eigth, tied_e_dq, quarter, dotted_quarter, dotted_half, eigth, tied_e_dq, quarter, dotted_quarter, dotted_half, eigth, tied_e_w_w};
keys = [Bb4 Bb4 0 Db4 Eb4 Bb4 Bb4 0 Db4 Eb4 Bb4 Eb4 0 Db4 Eb4];
for i = 1:length(keys)
    t1 = time_array{i};
    A_t = (exp(-t1/T)); % exponential decay function
    if keys(i) == 0
        y = zeros(size(time_array{i}));
    else
       y = (1/1)*A_t.*cos(2 * pi * keys(i) * time_array{i}); % fundamental
       y = y + (1/2)*A_t.*cos(2 * pi * (2*keys(i)) * time_array{i}); % 2nd harmonic
    end
    treble_song = [treble_song, y];
end

% Bass Portion - Phases 1, 2, 1, 2, 3, 4, 5, 6
bass_song = [];
for g = 1:4
    bass_t_array = {whole, whole, tied_w_h, eigth, dotted_quarter, whole, whole, tied_w_h, eigth, dotted_quarter};
    bass_keys = {[Ab2 Cb3 Eb3 Gb3] [Bb2 Db3 F3 Ab3] [Cb3 Eb3 Gb3 Bb3] 0 [Bb2 Db3 F3 Ab3] [Ab2 Cb3 Eb3 Gb3] [Bb2 Db3 F3 Ab3] [Db3 Eb3 Gb3 Bb3] Eb3 Db3};
    for k = 1:length(bass_keys)
        vec = bass_keys{k};
        tb = bass_t_array{k};
        t2 = bass_t_array{k};
        A_t = (exp(-t2/T)); % exponential decay function
        if isequal(vec, 0)
            y = zeros(size(tb));
        else
            y = zeros(size(tb));
            for i = 1:length(vec)
                y = y + (1/1)*A_t.*cos(2 * pi * vec(i) * tb); % fundamental
                y = y + (1/2)*A_t.*cos(2 * pi * (2*vec(i)) * tb); % 2nd harmonic
                y = y + (1/3)*A_t.*cos(2 * pi * (3*vec(i)) * tb); % 3rd harmonic
            end
            y = y / length(vec); 
        end
        bass_song = [bass_song, y];
    end
end

% Bass Portion - Phases 7 & 8
for j = 1:2
    bass_t_array = {whole, whole, tied_w_h, eigth, dotted_quarter};
    bass_keys = {[Ab2 Cb3 Eb3 Gb3] [Bb2 Db3 F3 Ab3] [Db3 Eb3 Gb3 Bb3] Eb3 Db3};
    for k = 1:length(bass_keys)
        vec = bass_keys{k};
        tb = bass_t_array{k};
        t2 = bass_t_array{k};
        A_t = (exp(-t2/T)); % exponential decay function
        if isequal(vec, 0)
            y = zeros(size(tb));
        else
            y = zeros(size(tb));
            for i = 1:length(vec)
                y = y + (1/1)*A_t.*cos(2 * pi * vec(i) * tb); % fundamental
                y = y + (1/2)*A_t.*cos(2 * pi * (2*vec(i)) * tb); % 2nd harmonic
                y = y + (1/3)*A_t.*cos(2 * pi * (3*vec(i)) * tb); % 3rd harmonic
            end
            y = y / length(vec);
        end
        bass_song = [bass_song, y];
    end
end

% Combine treble and bass portions
% set each to same length, (they are currently off by 0.0004 seconds)
min_length = min(length(treble_song), length(bass_song)); 
song = treble_song(1:min_length) + bass_song(1:min_length);

% Reverb/Echo
delay_time_T = 0.1;  % Echo delay in seconds (T)
alpha = 0.1; % Attenuation of the echo
delay_samples = round(delay_time_T * fs);
echo = alpha * [zeros(1, delay_samples), song(1:end-delay_samples)];
song = song + echo; % r(t) = s(t) + s_e(t)

% Normalize final array
songnorm = song / max(abs(song));

% Play combined portion to ensure no part starts before the other
soundsc(songnorm, fs)

% Convert to .wav file
filename = 'Jones_ChamberofReflection.wav';
audiowrite(filename, songnorm, fs)

% Tests:
% length(bass_song)/fs
% length(treble_song)/fs
