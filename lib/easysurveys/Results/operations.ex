defmodule Easysurveys.Results.Operations do
    import Ecto.Query

    def save_results(key, result) do
        result = %Easysurveys.Results.Result{key: key, result: result}
        Easysurveys.Repo.insert(result) |> elem(0) |> db_response
    end

    def get_results(key) do
      query = from p in "result", where: p.key == ^key, select: p.result   

      results = 
        query 
        |> Ecto.Queryable.to_query  
        |> Easysurveys.Repo.all

      results = for result <- results, do: Poison.decode(result) |> elem(1)

      results = 
        for result <- results do 
          Enum.reduce(result, [], fn({_k, v}, acc) -> 
            #if v["label"] != "Header" && v["label"] != "Paragraph" do
              acc ++ [%{input: v["type"], label: v["label"], value: v["userData"]}] 
            #end
          end)
        end

      results = for x <- results, do: for y <- x, y.input != "header" && y.input != "paragraph", do: y
      count = length(results)
      first_result = Enum.at(results, 0)
      results = List.flatten(results)
      new_map = for x <- first_result, do: %{label: x.label, input: x.input, values: nil}

      new_list = make_new_list(new_map, results, [], [])

      IO.inspect(results)
      IO.inspect(new_list)

      {new_list, count}

    end

    defp make_new_list([], _results, new_list, _current_values) do
      new_list
    end

    defp make_new_list([h | t], results, new_list, current_values) do
      current_values =
        for x <- results do
          if h.label == x.label do
            current_values ++ x.value
          end
        end
      
      current_values = for x <- current_values, x != nil, do: x
      current_values = List.flatten(current_values)

      new_list = new_list ++ [%{h | values: current_values}]

      make_new_list(t, results, new_list, [])

    end

    defp db_response(query_resp) do
        case query_resp do
          1 ->
            "Ok."
          :ok ->
            "Ok."
          error ->
            "Error #{inspect(error)}."
        end
      end
end