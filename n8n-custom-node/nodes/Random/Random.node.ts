import {
  IExecuteFunctions,
  INodeExecutionData,
  INodeType,
  INodeTypeDescription,
  NodeOperationError,
} from 'n8n-workflow';

export class Random implements INodeType {
  description: INodeTypeDescription = {
    displayName: 'Random',
    name: 'random',
    icon: 'file:random.svg',
    group: ['utility'],
    version: 1,
    subtitle: '={{$parameter["operation"]}}',
    description: 'Generate true random numbers using Random.org API',
    defaults: {
      name: 'Random',
    },
    inputs: ['main'] as any,
    outputs: ['main'] as any,
    properties: [
      {
        displayName: 'Operation',
        name: 'operation',
        type: 'options',
        noDataExpression: true,
        options: [
          {
            name: 'True Random Number Generator',
            value: 'generateRandomNumber',
            description: 'Generate a true random number using Random.org API',
            action: 'Generate a true random number',
          },
        ],
        default: 'generateRandomNumber',
      },
      {
        displayName: 'Minimum Value',
        name: 'min',
        type: 'number',
        default: 1,
        required: true,
        description: 'The minimum value for the random number (inclusive)',
        displayOptions: {
          show: {
            operation: ['generateRandomNumber'],
          },
        },
      },
      {
        displayName: 'Maximum Value',
        name: 'max',
        type: 'number',
        default: 100,
        required: true,
        description: 'The maximum value for the random number (inclusive)',
        displayOptions: {
          show: {
            operation: ['generateRandomNumber'],
          },
        },
      },
    ],
  };

  async execute(this: IExecuteFunctions): Promise<INodeExecutionData[][]> {
    const items = this.getInputData();
    const returnData: INodeExecutionData[] = [];

    for (let i = 0; i < items.length; i++) {
      try {
        const operation = this.getNodeParameter('operation', i) as string;

        if (operation === 'generateRandomNumber') {
          const min = this.getNodeParameter('min', i) as number;
          const max = this.getNodeParameter('max', i) as number;

          if (min > max) {
            throw new NodeOperationError(
              this.getNode(),
              'Minimum value cannot be greater than maximum value',
              { itemIndex: i }
            );
          }

          const apiUrl = `https://www.random.org/integers/?num=1&min=${min}&max=${max}&col=1&base=10&format=plain&rnd=new`;

          const response = await this.helpers.request({
            method: 'GET',
            url: apiUrl,
            headers: {
              'User-Agent': 'n8n-random-node/1.0.0',
            },
          });

          const randomNumber = parseInt(response.trim(), 10);

          if (isNaN(randomNumber)) {
            throw new NodeOperationError(
              this.getNode(),
              'Failed to parse random number from Random.org response',
              { itemIndex: i }
            );
          }

          returnData.push({
            json: {
              randomNumber,
              min,
              max,
              source: 'random.org',
              timestamp: new Date().toISOString(),
            },
            pairedItem: {
              item: i,
            },
          });
        }
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : 'Unknown error';
        if (this.continueOnFail()) {
          returnData.push({
            json: {
              error: errorMessage,
            },
            pairedItem: {
              item: i,
            },
          });
          continue;
        }
        throw error;
      }
    }

    return [returnData];
  }
}