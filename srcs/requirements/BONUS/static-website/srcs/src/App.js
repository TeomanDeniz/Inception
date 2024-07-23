/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   App.js                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/07/22 12:48:13 by hdeniz            #+#    #+#             */
/*   Updated: 2024/07/22 12:51:01 by hdeniz           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

import React, { useState } from 'react';
import SearchBar from './SearchBar';
import PokemonCard from './PokemonCard';

function App()
{
  const [pokemonData, setPokemonData] = useState(null);
  const handlePokemonSearch = async (pokemonName) =>
  {
    if (pokemonName.trim() === '')
    {
      setPokemonData(null);
      return ;
    }

    try
    {
      const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemonName}`);

      if (!response.ok)
        throw new Error('No results found');

      const data = await response.json();
      setPokemonData(data);
    }
    catch (error)
    {
      console.error('Error fetching data:', error);
      setPokemonData(null);
    }
  };

  return (
    <div className="app">
      <h1 style={{ textAlign: 'center', fontFamily: 'Calibri' }}>
        Another Pokemon Search</h1>
      <h3 style={{ textAlign: 'center', fontFamily: 'Calibri' }}>
        When there's no more irony left, we can always count on Pokémon\
        </h3>
      <SearchBar onSearch={handlePokemonSearch} /> 
      <PokemonCard pokemonData={pokemonData} />
    </div>
  );
}

export default App;