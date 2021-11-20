
function astro -d "Enter your star sign to get a horoscope for the day."
    curl -s https://ohmanda.com/api/horoscope/$argv[1]/ | jq ".horoscope" | cowsay -f dragon
end