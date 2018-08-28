#'Play a short sound
#'
#'\code{beep} plays a short sound which is useful if you want to get notified, 
#'for example, when a script has finished. As an added bonus there are a number 
#'of different sounds to choose from.
#'
#'If \code{beep} is not able to play the sound a warning is issued rather than 
#'an error. This is in order to not risk aborting or stopping the process that
#'you wanted to get notified about.
#'
#'@param sound character string or number specifying what sound to be played by 
#'  either specifying one of the built in sounds, specifying the path to a wav 
#'  file or specifying an url. The default is 1. Possible sounds are:
#'  \enumerate{ \item \code{"ping"} \item \code{"coin"} \item \code{"fanfare"}
#'  \item \code{"complete"} \item \code{"treasure"} \item \code{"ready"} \item
#'  \code{"shotgun"} \item \code{"mario"} \item \code{"wilhelm"} \item
#'  \code{"facebook"} \item \code{"sword"} } If \code{sound} does not match any
#'  of the sounds above, or is a valid path or url, a random sound will be
#'  played. Currently \code{beep} can only handle http urls, https is not
#'  supported.
#'@param expr An optional expression to be excecuted before the sound.
#'  
#'  
#'@return NULL
#'  
#' @examples
#' # Play a "ping" sound
#' beep()
#' 
#' \dontrun{
#' # Play a fanfare instead of a "ping".
#' beep("fanfare")
#' # or
#' beep(3)
#' 
#' # Play a random sound
#' beep(0)
#' 
#' # Update all packages and "ping" when it's ready
#' update.packages(ask=FALSE); beep()
#' }
#'@export
beep.kaamelott <- function(sound=1, expr=NULL) {
  expr
  sounds <- c(pereunijambiste = "pereunijambiste.wav",
              corbeaudecede = "corbeaudecede.wav",
              cavaprendreuneplombe = "cavaprendreuneplombe.wav",
              commelaneige = "commelaneige.wav",
              jesurveillelestockdepain = "jesurveillelestockdepain.wav",
              chouette = "chouette.wav",
              miours = "mioursmiscorpion.wav",
              savoureusescotelettes = "savoureusescotelettes.wav",
              jetecrametafamille = "jetecrametafamille.wav",
              ellereste = "ellereste.wav",
              capique = "capique.wav",
              catapulteendives = "catapulteendives.wav",
              lecode = "lecode.wav",
              alavolette = "a_la_volette.wav",
              animauxdelaforet = "animaux_de_la_foret.wav",
              ave_cesar = "ave_cesar.wav",
              interprete = "interprete.wav",
              legraal = "le_graal_par_ci_le_graal_par_la.wav",2
              lespattes = "les_pattes_de_canard.wav",
              mecreant = "mecreant_2.wav",
              gros = "on_en_a_gros.wav",
              meule = "regardez_moi_cette_meule.wav",
              colere = "tres_en_colere.wav",
              woouhou = "wooouuuhouhouhou_c_est_mortel.wav",
              faux = "cest_pas_faux2.wav",
              doigts = "sortez-vous_les_doigts_du_cul.wav",
              mordu = "mordu.wav",
              forts = "on_est_forts.wav",
              revolte = "bon_ben_revolte.wav",
              ecole = "mon_frere_y_peut_pas_aller_a_l_ecole.wav",
              foutremerde = "venir_foutre_votre_merde.wav",
              graines = "je_ne_mange_pas_de_graines.wav",
              casuffit = "casuffit.wav",
              fulgurant = "fulgurant.wav",
              impressionnant = "vraiment_impressionnant.wav",
              pdg = "paysdegalles.wav")
  
  sound_path <- NULL
  if(is.na(sounds[sound]) || length(sounds[sound]) != 1) {
    if(is.character(sound)) {
      sound <- str_trim(sound)
      if(file.exists(sound)) {
        sound_path <- sound
      } else if(str_detect(sound, "^https://")) {
        warning("Can't currently use https urls, only http.")
      } else if(str_detect(sound, "^http://")) {
        temp_file <- tempfile(pattern="")
        if(download.file(sound, destfile = temp_file, quiet = TRUE) == 0) { # The file was successfully downloaded
          sound_path <- temp_file
        } else {
          warning(paste("Tried but could not download", sound))
        }
      } else {
        warning(paste('"', sound, '" is not a valid sound nor path, playing a random sound instead.', sep = ""))
      }
    }
  } else {
    sound_path <- system.file(paste("sounds/", sounds[sound], sep=""), package="beepr.kaamelott")
  }
  
  if(is.null(sound_path)) { # play a random sound
    sound_path <- system.file(paste("sounds/", sample(sounds, size=1), sep=""), package="beepr.kaamelott")
  }
  
  tryCatch(play_file(sound_path), error = function(ex) {
    warning("beep() could not play the sound due to the following error:\n", ex)
  })
}

#'Play a short sound if there is an error 
#'
#'\code{beep_on_error} wraps an expression and plays a short sound only if an 
#' error occurs. 
#'
#'If \code{beep} is not able to play the sound a warning is issued rather than 
#'an error. This is in order to not risk aborting or stopping the process that
#'you wanted to get notified about.
#'
#'@param expr An expression to be evaluated for errors.
#' 
#'@param sound character string or number specifying what sound to be played by 
#'  either specifying one of the built in sounds, specifying the path to a wav 
#'  file or specifying an url. The default is 1. Possible sounds are:
#'  \enumerate{ \item \code{"ping"} \item \code{"coin"} \item \code{"fanfare"}
#'  \item \code{"complete"} \item \code{"treasure"} \item \code{"ready"} \item
#'  \code{"shotgun"} \item \code{"mario"} \item \code{"wilhelm"} \item
#'  \code{"facebook"} \item \code{"sword"} } If \code{sound} does not match any
#'  of the sounds above, or is a valid path or url, a random sound will be
#'  played. Currently \code{beep} can only handle http urls, https is not
#'  supported.
#'  
#'  
#'@return NULL
#'  
#'@examples
#' # Play a "ping" sound if \code{expr} produces an error
#' beep_on_error(log("foo"))
#' 
#' # Stay silent if \code{expr} does not produce an error
#' beep_on_error(log(1))
#' 
#' \dontrun{
#' # Play the Wilhelm scream instead of a ping on error.
#' beep_on_error(runif("bar"), "wilhelm")
#' }
#' 
#'@export

beepk_on_error <- function(expr, sound = 1) {
  q_expr <- substitute(expr)
  
  msg <- paste0("An error occurred in ", deparse(q_expr))
  e <- simpleError(msg)
  
  tryCatch(expr, error = function(e) {
    message(paste0(msg, ": ", e$message))
    beep.kaamelott(sound)
  })
}

is_wav_fname <- function(fname) {
  str_detect(fname, regex("\\.wav$", ignore_case = TRUE))
}

escape_spaces <- function(s) {
  str_replace_all(s, " ", "\\\\ ")
}

play_vlc <- function(fname) {
  fname <- escape_spaces(fname)
  system(paste0("vlc -Idummy --no-loop --no-repeat --playlist-autostart --no-media-library --play-and-exit ", fname), 
         ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
  invisible(NULL)
}

play_paplay <- function(fname) {
  fname <- escape_spaces(fname)
  system(paste0("paplay ", fname), ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
  invisible(NULL)
}

play_aplay <- function(fname) {
  fname <- escape_spaces(fname)
  system(paste0("aplay --buffer-time=48000 -N -q ", fname), ignore.stdout = TRUE, ignore.stderr=TRUE,wait = FALSE)
  invisible(NULL)
}

play_audio <- function(fname) {
  sfx <- load.wave(fname)
  play(sfx)
}

play_file <- function(fname) {
  if(Sys.info()["sysname"] == "Linux") {
     if(is_wav_fname(fname) && nchar(Sys.which("paplay")) >= 1) {
      play_paplay(fname)
    } else if(is_wav_fname(fname) && nchar(Sys.which("aplay")) >= 1) {
      play_aplay(fname)
    } else if(nchar(Sys.which("vlc")) >= 1) {
      play_vlc(fname)
    } else {
      play_audio(fname)
    }
  } else {
    play_audio(fname)
  }
}